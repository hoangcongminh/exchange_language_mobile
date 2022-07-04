import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/group_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc(this.groupRepository) : super(GroupInitial()) {
    on<GroupEvent>((event, emit) {});
  }

  GroupRepository groupRepository;
}
