
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:flutter/material.dart';
@immutable
abstract class DetailsNewsEvent {}

class DetailsNewsFetchEvent extends DetailsNewsEvent {
  final News news;
  DetailsNewsFetchEvent(this.news);
}

class DetailNewsAddFavoriteEvent extends DetailsNewsEvent {
  final News data;
  DetailNewsAddFavoriteEvent(this.data);
}

class DetailNewsDeleteFavoriteEvent extends DetailsNewsEvent {
  final News data;
  DetailNewsDeleteFavoriteEvent(this.data);
}
