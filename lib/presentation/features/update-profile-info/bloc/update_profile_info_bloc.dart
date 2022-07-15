import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/local/user_local_data.dart';
import '../../../../domain/entities/user.dart';

part 'update_profile_info_event.dart';
part 'update_profile_info_state.dart';

class UpdateProfileInfoBloc
    extends Bloc<UpdateProfileInfoEvent, UpdateProfileInfoState> {
  UpdateProfileInfoBloc() : super(UpdateProfileInfoInitial()) {
    on<UpdateProfileInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchProfileInfoEvent>(onFetchProfileInfo);
  }

  onFetchProfileInfo(
      FetchProfileInfoEvent event, Emitter<UpdateProfileInfoState> emit) {
    print('run');
    emit(LoadingUpdateProfileInfo());
    final user = UserLocal().getUser();
    emit(LoadedUpdateProfileInfo(user!));
  }
}
