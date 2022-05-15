import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exchange_language_mobile/data/models/media_model.dart';
import 'package:retrofit/http.dart';
import 'package:http_parser/http_parser.dart';

import '../../models/api_response_model.dart';

part 'media_rest_client.g.dart';

@RestApi()
abstract class MediaRestClient {
  factory MediaRestClient(Dio dio, {String baseUrl}) = _MediaRestClient;

  @POST('/medias/picture')
  @MultiPart()
  Future<ApiResponseModel<MediaModel>> uploadImage(
    @Part(
      name: 'picture',
      contentType: 'image/jpeg',
    )
        File image,
  );

  @GET('/medias/{imageId}')
  Future<ApiResponseModel> getImageFromId(
    @Path('imageId') String imageId,
  );
}
