import 'package:wrestling_hub/src/domain/main/entities/main_entity.dart';

import 'news.dart';

class MainModel extends MainEntity {

  MainModel({
    super.auth,
    super.message,
    super.currentTime,
    super.timeZone,
    super.timeFormat,
    super.adsList,
    super.newsTopHeadlines,
    super.news,
  });


  MainModel.fromJson(Map<String, dynamic> parsed) {
      auth = parsed['auth'] ?? '';
      message = parsed['message'] ?? '';
      currentTime = parsed['current_time'] ?? '';
      timeZone = parsed['time_zone'] ?? '';
      timeFormat = parsed['time_format'] ?? '';
      news = List<News>.from(parsed["news"].map((x) => News.fromJson(x))??{});
      newsTopHeadlines = List<News>.from(parsed["top_headlines"].map((x) => News.fromJson(x))??{});

    }

  factory MainModel.fromEntity(MainEntity entity) {
    return MainModel(
      auth: entity.auth,
      message: entity.message,
      currentTime: entity.currentTime,
      timeZone: entity.timeZone,
      timeFormat: entity.timeFormat,
      adsList: entity.adsList,
      newsTopHeadlines: entity.newsTopHeadlines,
      news: entity.news,
    );
  }

}