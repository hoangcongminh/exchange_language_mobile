import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState(index: 0)) {
    on<OnChangeIndexEvent>((event, emit) {
      _handleChangeIndex(event);
      emit(DashboardState(index: currentIndex));
    });
  }

  _handleChangeIndex(OnChangeIndexEvent event) {
    currentIndex = event.index;
  }

  int currentIndex = 0;
}
