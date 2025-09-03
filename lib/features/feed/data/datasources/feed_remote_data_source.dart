import 'package:dio/dio.dart';

import '../../domain/entities/post.dart';
import '../../domain/entities/comment.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';

abstract class FeedRemoteDataSource {
  Future<List<Post>> getPosts(int page);
  Future<Post> likePost(String postId);
  Future<List<Comment>> getComments(String postId);
  Future<Comment> addComment(String postId, String text);
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final Dio dio;

  FeedRemoteDataSourceImpl({Dio? client}) : dio = client ?? Dio();

  @override
  Future<List<Post>> getPosts(int page) async {
    // Using jsonplaceholder for posts, users, and picsum/videos for media
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10',
    );
    final usersResponse = await dio.get(
      'https://jsonplaceholder.typicode.com/users',
    );

    final users =
        (usersResponse.data as List).map((u) => UserModel.fromJson(u)).toList();

    return (response.data as List).map((json) {
      final user = users.firstWhere(
        (u) => u.id == json['userId'].toString(),
        orElse: () => users[0],
      );

      // 🔑 Every 5th post is a video
      final isVideo = (json['id'] as int) % 5 == 0;

      return PostModel.fromJson({
        'id': json['id'],
        'user': {'id': user.id, 'name': user.name, 'avatar': user.avatarUrl},
        'content': json['body'],
        'mediaUrl':
            isVideo
                ? 'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4'
                : 'https://picsum.photos/seed/${json['id']}/500/300',
        'isVideo': isVideo,
        'likes': (json['id'] as int) * 3,
        'isLiked': false,
        'comments': [],
        'createdAt': DateTime.now().toIso8601String(),
      });
    }).toList();
  }

  @override
  Future<Post> likePost(String postId) async {
    // Mock like API response
    return PostModel.fromJson({
      'id': postId,
      'user': {
        'id': '1',
        'name': 'Demo User',
        'avatar': 'https://i.pravatar.cc/150?img=1',
      },
      'content': 'Liked post',
      'mediaUrl': 'https://picsum.photos/500/300',
      'isVideo': false,
      'likes': 1,
      'isLiked': true,
      'comments': [],
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<List<Comment>> getComments(String postId) async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/comments?postId=$postId',
    );

    return (response.data as List).map((json) {
      return CommentModel.fromJson({
        'id': json['id'],
        'user': {
          'id': json['email'],
          'name': json['name'],
          'avatar': 'https://i.pravatar.cc/150?u=${json['email']}',
        },
        'text': json['body'],
        'createdAt': DateTime.now().toIso8601String(),
      });
    }).toList();
  }

  @override
  Future<Comment> addComment(String postId, String text) async {
    // Mock post request
    final response = await dio.post(
      'https://jsonplaceholder.typicode.com/comments',
      data: {
        'postId': postId,
        'body': text,
        'email': 'demo@user.com',
        'name': 'Demo User',
      },
    );

    return CommentModel.fromJson({
      'id': response.data['id'] ?? DateTime.now().millisecondsSinceEpoch,
      'user': {
        'id': 'demo',
        'name': 'Demo User',
        'avatar': 'https://i.pravatar.cc/150?img=2',
      },
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }
}
