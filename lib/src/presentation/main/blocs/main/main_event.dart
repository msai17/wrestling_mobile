part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class NewsFetchEvent extends MainEvent {}
class NewsLoadMoreEvent extends MainEvent {}
class NewsFullEvent extends MainEvent {
  final String id;
  NewsFullEvent(this.id);
}
