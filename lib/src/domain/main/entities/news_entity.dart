import 'package:hive_flutter/adapters.dart';
class NewsEntity {

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? images;
  @HiveField(4)
  String? creationDateTime;
  @HiveField(5)
  String? status;
  @HiveField(6)
  String? link;
  @HiveField(7)
  String? key;
  @HiveField(8)
  String? author;
  @HiveField(9)
  String? commentsCount;

  NewsEntity(
      { this.id,
        this.title,
        this.description,
        this.images,
        this.creationDateTime,
        this.status,
        this.link,
        this.key,
        this.commentsCount,
        this.author,
      });
}