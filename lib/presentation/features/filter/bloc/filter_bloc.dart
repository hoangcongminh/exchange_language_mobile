import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../data/failure.dart';
import '../../../../domain/entities/language.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repository/filter_repository.dart';
import '../../../../domain/repository/language_repository.dart';
import '../../../../routes/app_pages.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc(this._languageRepository, this._filterRepository)
      : super(FilterInitial()) {
    on<SelectLanguageEvent>(_onSelectLanguage);
    on<SearchUserEvent>(_onSearchUser);
  }

  _onSelectLanguage(
      SelectLanguageEvent event, Emitter<FilterState> emit) async {
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
  }

  _onSearchUser(SearchUserEvent event, Emitter<FilterState> emit) async {
    emit(FilterLoading());
    Either<Failure, List<User>> result = await _filterRepository.searchUsers(
      type: event.type,
      speakingLanguages: event.speakingLanguages,
      learningLanguages: event.learningLanguage,
    );
    result.fold(
      (failue) {
        emit(FilterFailure());
      },
      (users) {
        emit(FilterResult(users: users));
        AppNavigator().push(RouteConstants.filterResult);
      },
    );
  }

  List<Language> selectedLanguage = [];
  final LanguageRepository _languageRepository;
  final FilterRepository _filterRepository;
}
