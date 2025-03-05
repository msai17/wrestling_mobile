import 'package:hive_flutter/adapters.dart';

import '../../../domain/main/entities/news_entity.dart';
part 'news.g.dart';


@HiveType(typeId: 0)
class News extends NewsEntity {

  News({
    super.id,
    super.title,
    super.description,
    super.images,
    super.creationDateTime,
    super.status,
    super.link,
    super.key,
    super.commentsCount,
    super.author,
  });



  News.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    images = json['images'] ?? '';
    creationDateTime = json['creation_date_time'] ?? '';
    status = json['status'] ?? '';
    link = json['link'] ?? '';
    key = json['key'] ?? '';
    author = json['author'] ?? '---';
    commentsCount = json['comments_count'] ?? '0';
  }

  factory News.fromEntity(NewsEntity entity) {
    return News(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      images: entity.images,
      creationDateTime: entity.creationDateTime,
      status: entity.status,
      link: entity.link,
      key: entity.key,
      author: entity.author,
      commentsCount: entity.commentsCount,
    );
  }

}