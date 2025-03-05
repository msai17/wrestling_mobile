import 'package:wrestling_hub/src/data/video/models/video.dart';

class CategoryVideoEntity {

  String? id;
  String? name;
  String? status;
  String? level;
  List<Video>? videos;

  CategoryVideoEntity({this.id,this.name,this.status,this.level,this.videos});
}