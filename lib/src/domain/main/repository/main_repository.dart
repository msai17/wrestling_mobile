import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/main/models/comment.dart';
import 'package:wrestling_hub/src/data/main/models/main_model.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';

abstract class MainRepository {
  Future<DataState<MainModel>>getMain(String page);
  Future<DataState<News>>getFullNews(String id);
  Future<DataState<List<News>>>getSearchNews(Map<String,String> data);
  Future<DataState<List<Comment>>>getCommentsNews(String id);
  Future<DataState<List<Comment>>>sendCommentNews(Map<String,String> data);
  Future<void>addFavorite(News news);
  Future<void>deleteFavorite(String id);
  Future<DataState<bool>>getStatusFavorite(News news);
  Future<DataState<List<News>>>getFavoriteNews();
}