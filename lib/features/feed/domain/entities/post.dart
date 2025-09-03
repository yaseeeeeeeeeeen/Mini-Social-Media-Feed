import 'package:equatable/equatable.dart';
import 'user.dart';
import 'comment.dart';

class Post extends Equatable {
  final String id;
  final User user;
  final String content;
  final String? mediaUrl;
  final bool isVideo;
  final int likes;
  final bool isLiked;
  final List<Comment> comments;
  final DateTime createdAt;

  const Post({
    required this.id,
    required this.user,
    required this.content,
    this.mediaUrl,
    this.isVideo = false,
    this.likes = 0,
    this.isLiked = false,
    this.comments = const [],
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    content,
    mediaUrl,
    isVideo,
    likes,
    isLiked,
    comments,
    createdAt,
  ];
}
