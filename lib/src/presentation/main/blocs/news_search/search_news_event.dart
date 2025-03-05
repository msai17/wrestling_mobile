import 'package:flutter/material.dart';

@immutable
abstract class SearchNewsEvent {}

class SearchNewsFetchEvent extends SearchNewsEvent {
  final String query;
  SearchNewsFetchEvent(this.query);
}

class SearchNewsMoreEvent extends SearchNewsEvent {
  final String query;
  SearchNewsMoreEvent(this.query);
}