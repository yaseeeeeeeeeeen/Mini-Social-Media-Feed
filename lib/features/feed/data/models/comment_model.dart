import '../../domain/entities/comment.dart';
import '../../domain/entities/user.dart';
import 'user_model.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.user,
    required super.text,
    required super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'].toString(),
      user: UserModel.fromJson(json['user'] ?? {}),
      text: json['text'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': (user as User).id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
