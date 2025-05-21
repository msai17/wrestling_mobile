import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/src/data/video/models/category_video.dart';

abstract class VideoRemoteDataSource {
  factory VideoRemoteDataSource(Dio dio) = _VideoRemoteDataSource;
  Future<HttpResponse<List<CategoryVideo>>> getVideos();
}
class _VideoRemoteDataSource implements VideoRemoteDataSource {

  final Dio client;

  _VideoRemoteDataSource(this.client);

  @override
  Future<HttpResponse<List<CategoryVideo>>> getVideos() async{
    final request = await client.get(
      AppUrls.getVideos,
    );


    final List<CategoryVideo> value;
    try{
      Iterable news = jsonDecode(request.data)['categories'] ?? [];
      value = news.map((i) => CategoryVideo.fromJson(i)).toList();}
    catch(e) {
      rethrow;
    }
    return HttpResponse(value, request);
  }
}