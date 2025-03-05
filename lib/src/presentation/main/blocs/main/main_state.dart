part of 'main_bloc.dart';


abstract class NewsState{

}

class InitMainState extends NewsState {}

class MainLoadingState extends NewsState {}

class MainLoadedState extends NewsState {
  final List<News>? topNewsHeadlines;
  final List<News> news;
  MainLoadedState({required this.news,required this.topNewsHeadlines});
}

class MainErrorState extends NewsState {
  String error;
  MainErrorState({required this.error});
}

