import 'package:exchange_language_mobile/domain/entities/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_model.g.dart';

@JsonSerializable()
class MediaModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'name')
  final String filename;

  @JsonKey(name: 'src', includeIfNull: false)
  final String? src;

  MediaModel(
    this.id,
    this.filename,
    this.src,
  );

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);

  Media toEntity() => Media(
        id: id,
        filename: filename,
        src: src,
      );
}
