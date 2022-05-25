import 'package:exchange_language_mobile/data/datasources/remote/filter_rest_client.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';

import 'package:exchange_language_mobile/data/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/filter_repository.dart';
import '../datasources/remote/app_api_service.dart';

class FilterRepositoryImpl extends FilterRepository {
  final FilterRestClient _filterRestClient = AppApiService().filterRestClient;

  @override
  Future<Either<Failure, List<User>>> searchUsers() async {
    try {
      final response = await _filterRestClient.searchUsers();
      if (response.error == false) {
        return Right(response.data!.data.map((e) => e.toEntity()).toList());
      } else {
        return Left(ServerFailure(response.message));
      }
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
