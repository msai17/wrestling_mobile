import 'package:hive_flutter/adapters.dart';

class VideoEntity {

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? status;
  @HiveField(4)
  String? creationDateTime;
  @HiveField(5)
  String? categoryId;
  @HiveField(6)
  String? urlVideo;
  @HiveField(7)
  String? urlPreview;
  @HiveField(8)
  String? urlImage;
  @HiveField(9)
  String? type;
  @HiveField(10)
  String? source;
  @HiveField(11)
  String? iconSource;

  VideoEntity({
    this.id,
    this.name,
    this.description,
    this.status,
    this.creationDateTime,
    this.categoryId,
    this.urlVideo,
    this.urlPreview,
    this.urlImage,
    this.type,
    this.source,
    this.iconSource,
  });
}