

import 'package:wrestling_hub/src/data/main/models/news.dart';

abstract class DetailsNewsState{

}

class DetailsNewsInitState extends DetailsNewsState {}

class DetailsNewsLoadingState extends DetailsNewsState {}

class DetailsNewsSuccessState extends DetailsNewsState {
  News? full;
  bool isFavorite;
  DetailsNewsSuccessState({required this.full,required this.isFavorite});
}

class DetailsNewsErrorState extends DetailsNewsState {
  String error;
  DetailsNewsErrorState({required this.error});
}

