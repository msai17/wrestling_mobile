import 'package:hive_flutter/adapters.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';

class MainLocalDataSource {
  final Box<News> boxNews;

  MainLocalDataSource(this.boxNews);

  List<News> getFavoritesNews() {
    return boxNews.values.toList();
  }

  void addFavorite(News data) async {
    await boxNews.put(data.id, data);
  }

  void delete(String id) {
    boxNews.delete(id);
  }

  bool checkFavorite(News data) {
    if(boxNews.get(data.id) != null) {
      return true;
    }
    return false;
  }

  void clear() {
    boxNews.clear();
  }

}
