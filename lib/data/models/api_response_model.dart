import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<T> {
  @JsonKey(name: 'error')
  final bool error;
  @JsonKey(name: 'data')
  final T? data;
  @JsonKey(name: 'message')
  final String message;

  ApiResponseModel(this.error, this.data, this.message);

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseModelToJson(this, toJsonT);
}
