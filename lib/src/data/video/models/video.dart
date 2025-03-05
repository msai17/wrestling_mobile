import 'package:hive_flutter/adapters.dart';
import 'package:wrestling_hub/src/domain/video/entities/video_entity.dart';
part 'video.g.dart';

@HiveType(typeId: 1)
class Video extends VideoEntity {


  Video({
     super.id,
     super.name,
     super.description,
     super.status,
     super.creationDateTime,
     super.categoryId,
     super.urlVideo,
     super.urlPreview,
     super.urlImage,
     super.type,
     super.source,
     super.iconSource
  });


  Video.fromJson(Map<String,dynamic> data) {
    id = data['id'] ?? '';
    name = data['name'] ?? '';
    description = data['description'] ?? '';
    status = data['status'] ?? '';
    creationDateTime = data['creation_date_time'] ?? '';
    urlVideo = data['url_video'] ?? '';
    urlPreview = data['url_preview'] ?? '';
    urlImage = data['url_image'] ?? '';
    type = data['type'] ?? '';
    source = data['source'] ?? '';
    iconSource = data['icon_source'] ?? '';
  }




}