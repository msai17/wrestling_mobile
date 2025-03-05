import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:wrestling_hub/src/domain/user/usecases/get_user_use_case.dart';


part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final Logger _logger;
  final GetUserUseCase _getUserUseCase;
  final UserData _userData;


  SplashBloc(
      this._getUserUseCase,
      this._logger,
      this._userData,
      ) : super(SplashInitialState()) {
    on<SplashGetUserEvent>(_onGetUser);
  }



  _onGetUser(SplashGetUserEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(milliseconds: 100));

    //первый запуск
    if(!_userData.isFirstLaunch()) {
      await Future.delayed(const Duration(milliseconds: 500));
      return emit(SplashFirstLaunchState());
    }

    //Пользователь запустил но не зарегистрировался
    if(_userData.isFirstLaunch() &&  !_userData.isLogged()!) {
      return emit(SplashLoggedState());
    }

    final dataState = await _getUserUseCase(params: _userData.getAccessToken());

    //Произошла ошибка
    if (dataState is DataFailed) {
      _logger.e(dataState.error);
      return emit(SplashFailedState(dataState.error.toString()));
    }
    //Успещно
    if (dataState is DataSuccess) {
      if(dataState.data != null) {
        return emit(SplashLoggedState());
      }
    }
  }



}
