part of 'favorite_bloc.dart';

abstract class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoadedState extends FavoriteState {
  List<News>? news;
  List<Video>? videos;
  FavoriteLoadedState({this.news,this.videos});
}