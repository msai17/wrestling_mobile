
import 'package:wrestling_hub/src/data/main/models/news.dart';

class MainEntity {

  bool? auth;
  String? message;
  String? currentTime;
  String? timeZone;
  String? timeFormat;
  List<String>? adsList;
  List<News>? newsTopHeadlines;
  List<News>? news;

  MainEntity({
    this.auth,
    this.message,
    this.currentTime,
    this.timeZone,
    this.timeFormat,
    this.adsList,
    this.newsTopHeadlines,
    this.news,
  });
}