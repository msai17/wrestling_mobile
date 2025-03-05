import 'package:wrestling_hub/src/domain/main/entities/comment_entity.dart';

class Comment extends CommentEntity {

  Comment({
    super.id,
    super.status,
    super.creationDateTime,
    super.firstName,
    super.userId,
    super.newsId,
    super.text,
    super.avatars,
  });


  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    status = json['status'] ?? '';
    creationDateTime = json['creation_date_time'] ?? '';
    firstName = json['first_name'] ?? '';
    userId = json['user_id'] ?? '';
    newsId = json['news_id'] ?? '';
    text = json['text'] ?? '';
    avatars = json['avatars'] ?? '';
  }


}