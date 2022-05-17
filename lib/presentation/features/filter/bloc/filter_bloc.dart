import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/failure.dart';
import '../../../../domain/entities/language.dart';
import '../../../../domain/repository/language_repository.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc(this._languageRepository) : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {
      // TODO: implement event handler
    });

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
  }

  final LanguageRepository _languageRepository;
}
