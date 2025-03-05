import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:wrestling_hub/src/domain/user/usecases/get_local_user_usecase.dart';



part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Logger _logger;
  final GetLocalUserUseCase _getLocalUserUseCase;
  final UserData _userData;


  ProfileBloc(
      this._getLocalUserUseCase,
      this._logger,
      this._userData,
      ) : super(ProfileInitial()) {
    on<ProfileGetLocalEvent>(_onGetLocalUser);
    on<ProfileExitEvent>(_onExitAccount);
  }

  _onExitAccount(ProfileExitEvent event, Emitter<ProfileState> emit) {
    _userData.currentUser = null;
    _userData.dropUserData();
    emit(ProfileNoLoggedState());
  }

  _onGetLocalUser(ProfileGetLocalEvent event, Emitter<ProfileState> emit) async {
    final dataState = await _getLocalUserUseCase();

    if (dataState is DataFailed) {
      return emit(ProfileNoLoggedState());
    }

    if(dataState is DataSuccess) {
      return emit(ProfileLoggedState(dataState.data!,getStatusUser(dataState.data!.status!)).copyWith(user: dataState.data!,icon: getStatusUser(dataState.data!.status!)));
    }
  }

  Icon getStatusUser (String status) {
    if(status == '1') {
      return const Icon(Icons.verified,color: Colors.cyan);
    }
    if(status == '2') {
      return const Icon(Icons.verified,color: Colors.amber);
    }
    if(status == '3') {
      return const Icon(Icons.visibility_outlined,color: Colors.red);
    }


    return const Icon(Icons.verified,color: Colors.blueGrey);

  }

}
