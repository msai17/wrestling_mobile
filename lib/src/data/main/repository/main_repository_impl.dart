import 'dart:io';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/main/data_source/api/main_data_source.dart';
import 'package:wrestling_hub/src/data/main/data_source/local/main_local_data_source.dart';
import 'package:wrestling_hub/src/data/main/models/comment.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wrestling_hub/src/data/main/models/main_model.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/domain/main/repository/main_repository.dart';


class MainRepositoryImpl extends MainRepository {


  final MainDataSource _dataSource;
  final MainLocalDataSource _localDataSource;
  final Logger _logger;


  MainRepositoryImpl(this._dataSource, this._localDataSource, this._logger);
  
  @override
  Future<DataState<MainModel>> getMain(String page) async {
    try {
      final httpResponse = await _dataSource.getMain(page);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(customException(httpResponse));
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }

  @override
  Future<DataState<News>> getFullNews(String id) async {
    try {
      final httpResponse = await _dataSource.getFullNews(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(customException(httpResponse));
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }

  @override
  Future<DataState<List<News>>> getSearchNews(Map<String,String> data) async {
    try {
      final httpResponse = await _dataSource.getSearchNews(data);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(customException(httpResponse));
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }

  @override
  Future<DataState<List<Comment>>> getCommentsNews(String id) async {
    try {
      final httpResponse = await _dataSource.getCommentNews(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print(httpResponse.data);
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(customException(httpResponse));
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }

  @override
  Future<DataState<List<Comment>>> sendCommentNews(Map<String, String> data) async {
    try {
      final httpResponse = await _dataSource.sendCommentNews(data);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print(httpResponse.data);
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(customException(httpResponse));
      }
    } on DioException catch (e) {
      _logger.e("error_log_DioException", error: e);
      return DataFailed(e.error.toString());
    }
  }

  String customException(HttpResponse httpResponse) {
    return DioException(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        requestOptions: httpResponse.response.requestOptions
    ).toString();
  }

  @override
  Future<void> addFavorite(News news) async {
    _localDataSource.addFavorite(news);
  }

  @override
  Future<void> deleteFavorite(String id) async {
    _localDataSource.delete(id);
  }

  @override
  Future<DataState<List<News>>> getFavoriteNews() async {
    try{
      return DataSuccess(_localDataSource.getFavoritesNews());
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<DataState<bool>> getStatusFavorite(News news) async {
    try{
      return DataSuccess(_localDataSource.checkFavorite(news));
    }
    catch(e) {
      rethrow;
    }
  }





}