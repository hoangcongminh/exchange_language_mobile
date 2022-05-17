import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'fullname')
  final String fullName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'avatar')
  final AvatarModel avatar;

  UserModel(
    this.id,
    this.fullName,
    this.email,
    this.avatar,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() => User(
        id: id,
        fullname: fullName,
        email: email,
        avatar: avatar.toEntity(),
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
