import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/language.dart';
import 'media_model.dart';

part 'language_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LanguageModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'thumbnail')
  final MediaModel thumbnail;

  const LanguageModel(
    this.id,
    this.name,
    this.code,
    this.thumbnail,
  );

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);

  Language toEntity() => Language(
        id: id,
        name: name,
        code: code,
        thumbnail: thumbnail.toEntity(),
      );
}
