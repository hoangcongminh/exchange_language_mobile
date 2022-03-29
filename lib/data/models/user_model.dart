import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'fullname')
  final String fullName;

  @JsonKey(name: 'email')
  final String email;

  UserModel(
    this.id,
    this.fullName,
    this.email,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() => User(
        id: id,
        fullname: fullName,
        email: email,
      );
}
