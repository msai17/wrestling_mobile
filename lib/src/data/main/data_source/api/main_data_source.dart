import 'dart:convert';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/src/data/main/models/comment.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:wrestling_hub/src/data/main/models/main_model.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';

abstract class MainDataSource {
  factory MainDataSource(Dio dio) = _MainDataSource;
  Future<HttpResponse<MainModel>> getMain(String page);
  Future<HttpResponse<News>> getFullNews(String id);
  Future<HttpResponse<List<News>>> getSearchNews(Map<String,String> data);
  Future<HttpResponse<List<Comment>>> getCommentNews(String id);
  Future<HttpResponse<List<Comment>>> sendCommentNews(Map<String,dynamic> data);
}


class _MainDataSource implements MainDataSource {

  final Dio client;


  _MainDataSource(this.client);

  @override
  Future<HttpResponse<MainModel>> getMain(String page) async {
    final request = await client.get(
        AppUrls.getMainContent,
        data: json.encode(
        {
          "page" : page
        }
      ));
    final MainModel value;
    try{
      value = MainModel.fromJson(jsonDecode(request.data));
    }catch(e) {
      rethrow;
    }
    return HttpResponse(value, request);
  }

  @override
  Future<HttpResponse<News>> getFullNews(String id) async {
    final request = await client.get(
        AppUrls.getFullNews,
        data: json.encode(
            {
              "id" : id
            }
        ));
    final News value;
    final parsed = jsonDecode(request.data);
    try{
      value = News.fromJson(parsed['full']);
    }catch(e) {
      rethrow;
    }
    return HttpResponse(value, request);
  }

  @override
  Future<HttpResponse<List<News>>> getSearchNews(Map<String,String> data) async {
    final request = await client.get(
        AppUrls.getSearchNews,
        data: json.encode(
            {
              "query" : data["query"],
              "page" : data["page"]
            }
        ));
    final List<News> value;
    try{
      Iterable news = jsonDecode(request.data)['news'] ?? [];
      value = news.map((i) => News.fromJson(i)).toList();
    }catch(e) {
      rethrow;
    }
    return HttpResponse(value, request);
  }

  @override
  Future<HttpResponse<List<Comment>>> getCommentNews(String id) async {
    final request = await client.get(
        AppUrls.getCommentNews,
        data: json.encode({"id" : id})
    );
    final List<Comment> value;
    try{
      Iterable news = jsonDecode(request.data)['comments'] ?? [];
      value = news.map((i) => Comment.fromJson(i)).toList();
    }catch(e) {
      rethrow;
    }

    return HttpResponse(value, request);
  }

  @override
  Future<HttpResponse<List<Comment>>> sendCommentNews(Map<String, dynamic> data) async {
    final request = await client.get(
        AppUrls.sendCommentNews,
        data: data
    );
    final List<Comment> value;
    try{
      Iterable news = jsonDecode(request.data)['comments'] ?? [];
      value = news.map((i) => Comment.fromJson(i)).toList();
    }catch(e) {
      rethrow;
    }

    return HttpResponse(value, request);
  }



}