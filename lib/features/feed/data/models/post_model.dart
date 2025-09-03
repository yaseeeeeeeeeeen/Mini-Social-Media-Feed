import '../../domain/entities/post.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/user.dart';
import 'user_model.dart';
import 'comment_model.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.user,
    required super.content,
    super.mediaUrl,
    super.isVideo = false,
    super.likes = 0,
    super.isLiked = false,
    super.comments = const [],
    required super.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'].toString(),
      user: UserModel.fromJson(json['user'] ?? {}),
      content: json['content'] ?? '',
      mediaUrl: json['mediaUrl'],
      isVideo: json['isVideo'] ?? false,
      likes: json['likes'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      comments:
          (json['comments'] as List<dynamic>? ?? [])
              .map((c) => CommentModel.fromJson(c))
              .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': (user as User).id,
      'content': content,
      'mediaUrl': mediaUrl,
      'isVideo': isVideo,
      'likes': likes,
      'isLiked': isLiked,
      'comments': comments.map((c) => (c as Comment).id).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
