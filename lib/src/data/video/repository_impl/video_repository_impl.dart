import 'dart:io';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:wrestling_hub/core/utils/extensions/extensions.dart';
import 'package:wrestling_hub/src/data/video/data_source/api/video_remote_data_source.dart';
import 'package:wrestling_hub/src/data/video/data_source/local/video_local_data_source.dart';
import 'package:wrestling_hub/src/data/video/models/category_video.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/domain/video/repository/video_repository.dart';

class VideoRepositoryImpl extends VideoRepository {

  final VideoRemoteDataSource _remoteDataSource;
  final VideoLocalDataSource _localDataSource;
  final Logger _logger;

  VideoRepositoryImpl(this._remoteDataSource, this._logger, this._localDataSource);

  @override
  Future<DataState<List<CategoryVideo>>> getVideos() async {
    try {
      final httpResponse = await _remoteDataSource.getVideos();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
  Future<void> addFavorite(Video video) async {
    _localDataSource.addFavorite(video);
  }

  @override
  Future<void> deleteFavorite(Video video) async {
    _localDataSource.deleteFavorite(video);
  }

  @override
  Future<List<Video>> getFavoriteVideos() async {
    return _localDataSource.getFavoriteVideos();

  }

  @override
  Future<bool> isFavorite(Video video) async {
    return _localDataSource.isFavorite(video);
  }
}