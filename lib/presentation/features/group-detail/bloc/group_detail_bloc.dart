import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'group_detail_event.dart';
part 'group_detail_state.dart';

class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  GroupDetailBloc() : super(GroupDetailInitial()) {
    on<GroupDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
