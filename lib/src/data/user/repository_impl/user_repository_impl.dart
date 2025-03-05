import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/resources/data_state_auth.dart';
import 'package:wrestling_hub/core/utils/extensions/extensions.dart';
import 'package:logger/logger.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_local_data_source.dart';
import 'package:wrestling_hub/src/data/user/data_source/remote/user_remote_data_source.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:wrestling_hub/src/domain/user/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {


  final UserLocalDataSource _localDataSource;
  final UserRemoteDataSource _remoteDataSource;
  final Logger _logger;
  final UserData _userData;


  UserRepositoryImpl(this._localDataSource, this._remoteDataSource, this._logger, this._userData);

  @override
  Future<DataState<User>> getLocalUser() async {
    try{
      _logger.e('user');
      return DataSuccess(_localDataSource.getUser());
    }catch (e ) {
      _logger.e('error');
      return const DataFailed("Ошибка");
    }
  }

  @override
  Future<DataState<String>> sendImageServer(File image) async {
    try {
      final httpResponse = await _remoteDataSource.sendImageToServer(image);
      if (httpResponse.response.statusCode == HttpStatus.ok && jsonDecode(httpResponse.response.data)['image'] != null) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(httpResponse.getException());
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }


  @override
  Future<DataState<User>> editUser(Map<String, dynamic> data) async {
    try {
      final httpResponse = await _remoteDataSource.editProfileUser(data);
      if (httpResponse.response.statusCode == HttpStatus.ok && jsonDecode(httpResponse.response.data)['user'] != null) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(httpResponse.getException());
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }

  @override
  Future<DataState<bool>> deleteUser(String token) async {
    try {
      final httpResponse = await _remoteDataSource.deleteProfileUser(token);
      if (httpResponse.response.statusCode == HttpStatus.ok && jsonDecode(httpResponse.response.data)['is_set']) {
        _localDataSource.deleteUser();
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(httpResponse.getException());
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }


  @override
  Future<DataStateAuth<User>> confirmSmsCode(Map<String, dynamic> data) async {
    print(data);
    try {
      final httpResponse = await _remoteDataSource.confirmSmsCode(data);
      if (httpResponse.response.statusCode == HttpStatus.ok && jsonDecode(httpResponse.response.data)['user'] != null) {
        _userData.setAccessToken(httpResponse.data.token!);
        _userData.currentUser = httpResponse.data;
        _userData.setFirstLaunch();
        return DataAuthSuccess(httpResponse.data);
      }
      if(httpResponse.response.statusCode == HttpStatus.ok && jsonDecode(httpResponse.response.data)['auth'] == false) {
        return const DataWrongCode("Ваш код неверный");
      }
      else {
        return const DataAuthFailed("Ошибка");
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataAuthFailed(e.error.toString());
    }
  }

  @override
  Future<DataState<User>> getUser(String token) async {
    try {
      final httpResponse = await _remoteDataSource.getUser(token);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _userData.currentUser = httpResponse.data;
        return DataSuccess(httpResponse.data);
      } else {
        return const DataFailed("Ошибка");
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }

}