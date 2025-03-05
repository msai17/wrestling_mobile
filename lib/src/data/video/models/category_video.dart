import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/domain/video/entities/category_video_entity.dart';

class CategoryVideo extends CategoryVideoEntity {


  CategoryVideo({required super.id, required super.name, required super.status, required super.level, required super.videos});

  CategoryVideo.fromJson(Map<String,dynamic> data) {
    id = data['id'];
    name = data['name'];
    status = data['status'];
    level = data['level'];
    videos = List<Video>.from(data["videos"].map((x) => Video.fromJson(x))??{});
  }

}