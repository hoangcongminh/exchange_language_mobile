import 'package:exchange_language_mobile/data/models/language_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'fullname')
  final String fullName;

  @JsonKey(name: 'role')
  final int? role;

  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;

  @JsonKey(name: 'avatar')
  final AvatarModel? avatar;

  @JsonKey(name: 'learn')
  final List<LanguageModel>? learningLanguage;

  @JsonKey(name: 'speak')
  final List<LanguageModel>? speakingLanguage;

  @JsonKey(name: 'teacher')
  final TeacherModel? teacher;

  @JsonKey(name: 'introduction', includeIfNull: false)
  final String? introduction;

  UserModel(
    this.id,
    this.fullName,
    this.role,
    this.email,
    this.avatar,
    this.learningLanguage,
    this.speakingLanguage,
    this.teacher,
    this.introduction,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() => User(
        id: id,
        fullname: fullName,
        role: role,
        email: email,
        avatar: avatar?.toEntity(),
        learningLanguage: learningLanguage?.map((e) => e.toEntity()).toList(),
        speakingLanguage: speakingLanguage?.map((e) => e.toEntity()).toList(),
        teacher: teacher?.toEntity(),
        introduction: introduction,
      );
}

@JsonSerializable(explicitToJson: true)
class TeacherModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'teach')
  final List<LanguageModel>? teachingLanguage;

  TeacherModel(
    this.id,
    this.teachingLanguage,
  );

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);

  Teacher toEntity() => Teacher(
        id: id,
        teachingLanguage: teachingLanguage?.map((e) => e.toEntity()).toList(),
      );
}

@JsonSerializable()
class AvatarModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'src')
  final String src;

  AvatarModel(this.id, this.src);

  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarModelToJson(this);

  Avatar toEntity() => Avatar(
        id: id,
        src: src,
      );
}

@JsonSerializable()
class UserSearchResponse {
  @JsonKey(name: 'data')
  final List<UserModel> data;

  UserSearchResponse(this.data);

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSearchResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ListUserModel {
  @JsonKey(name: 'data')
  final List<UserModel> data;
  @JsonKey(name: 'total')
  final int total;

  const ListUserModel(
    this.data,
    this.total,
  );

  factory ListUserModel.fromJson(Map<String, dynamic> json) =>
      _$ListUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListUserModelToJson(this);

  ListUser toEntity() => ListUser(
        users: data.map((e) => e.toEntity()).toList(),
        total: total,
      );
}
