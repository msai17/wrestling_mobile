import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:wrestling_hub/src/domain/user/usecases/edit_user_usecase.dart';
class FirebaseService {

  final _firebaseMessaging = FirebaseMessaging.instance;
  EditUserUseCase _userUpdateUseCase;
  UserData _userData;


  FirebaseService(this._userUpdateUseCase,this._userData);

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    if(Platform.isIOS) {
      final token = await _firebaseMessaging.getAPNSToken();
      await Future<void>.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      if(token!.isNotEmpty) {
        userUpdateFcmToken(token);
      }
    }else{
      final token = await _firebaseMessaging.getToken();
      if(token!.isNotEmpty) {
        userUpdateFcmToken(token);
      }
    }
  }


  void userUpdateFcmToken(String fcmToken) async {

    if(_userData.isLogged()!) {
      Map<String, dynamic> data = {
        "token": _userData.getAccessToken(),
        "push_token": fcmToken
      };

      final dataState = await _userUpdateUseCase(params: data);

      if(dataState is DataFailed) {
        print('Ошибка отправления токена');
      }

      if(dataState is DataSuccess) {
        print('Токен отправлено');
      }
    }else{
      print('Не зарегестрирован');
    }


  }



}