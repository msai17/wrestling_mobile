
import '../../../../data/main/models/news.dart';

abstract class SearchNewsState{

}

class SearchNewsInitState extends SearchNewsState {}

class SearchNewsLoadingState extends SearchNewsState {}

class SearchNewsSuccessState extends SearchNewsState {
  final List<News> news;
  SearchNewsSuccessState({required this.news});
}

class SearchNewsEmptyState extends SearchNewsState {
  SearchNewsEmptyState();
}

class SearchNewsErrorState extends SearchNewsState {
  String error;
  SearchNewsErrorState({required this.error});
}
