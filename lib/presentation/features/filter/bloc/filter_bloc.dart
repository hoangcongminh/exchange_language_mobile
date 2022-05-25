import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exchange_language_mobile/common/constants/route_constants.dart';
import 'package:exchange_language_mobile/domain/entities/user.dart';
import 'package:exchange_language_mobile/domain/repository/filter_repository.dart';
import 'package:exchange_language_mobile/routes/app_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/language.dart';
import '../../../../domain/repository/language_repository.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc(this._languageRepository, this._filterRepository)
      : super(FilterInitial()) {
    on<SelectLanguageEvent>((event, emit) async {
      Either<Failure, List<Language>> result =
          await _languageRepository.getLanguages();
      result.fold(
        (failure) {
          emit(FilterFailure());
        },
        (languages) {
          emit(SelectLanguageState(languages: languages));
        },
      );
    });

    on<SearchUserEvent>(((event, emit) async {
      Either<Failure, List<User>> result =
          await _filterRepository.searchUsers();
      result.fold(
        (failue) {
          emit(FilterFailure());
        },
        (users) {
          emit(FilterResult(users: users));
          AppNavigator().push(RouteConstants.filterResult);
        },
      );
    }));
  }

  List<Language> selectedLanguage = [];
  final LanguageRepository _languageRepository;
  final FilterRepository _filterRepository;
}
