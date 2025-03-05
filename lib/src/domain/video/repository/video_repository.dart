import 'package:wrestling_hub/src/data/video/models/category_video.dart';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';

abstract class VideoRepository {
  Future<DataState<List<CategoryVideo>>> getVideos();
  Future<List<Video>> getFavoriteVideos();
  Future<void> addFavorite(Video video);
  Future<void> deleteFavorite(Video video);
  Future<bool> isFavorite(Video video);
}