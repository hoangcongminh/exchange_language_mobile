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

  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;

  @JsonKey(name: 'avatar')
  final AvatarModel avatar;

  @JsonKey(name: 'learn')
  final List<LanguageModel>? learningLanguage;

  @JsonKey(name: 'speak')
  final List<LanguageModel>? speakingLanguage;

  UserModel(
    this.id,
    this.fullName,
    this.email,
    this.avatar,
    this.learningLanguage,
    this.speakingLanguage,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() => User(
        id: id,
        fullname: fullName,
        email: email,
        avatar: avatar.toEntity(),
        learningLanguage: learningLanguage?.map((e) => e.toEntity()).toList(),
        speakingLanguage: speakingLanguage?.map((e) => e.toEntity()).toList(),
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
