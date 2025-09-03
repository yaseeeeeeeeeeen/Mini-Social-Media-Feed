import 'package:mini_social_media/features/feed/domain/entities/comment.dart';

import 'package:mini_social_media/features/feed/domain/entities/post.dart';

import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_source.dart';
import '../datasources/feed_local_data_source.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;
  final FeedLocalDataSource localDataSource;

  FeedRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Comment> addComment(String postId, String text) {
    // TODO: implement addComment
    throw UnimplementedError();
  }

  @override
  Future<List<Comment>> getComments(String postId) {
    // TODO: implement getComments
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPosts(int page) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Post> likePost(String postId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }
}
