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
  Future<List<Post>> getPosts(int page) async {
    try {
      final posts = await remoteDataSource.getPosts(page);
      await localDataSource.cachePosts(posts);
      return posts;
    } catch (e) {
      // fallback to cached posts
      return await localDataSource.getCachedPosts();
    }
  }

  @override
  Future<Post> likePost(String postId) async {
    try {
      final updated = await remoteDataSource.likePost(postId);
      // TODO: you could update local cache here if needed
      return updated;
    } catch (e) {
      throw Exception("Failed to like post: $e");
    }
  }

  @override
  Future<List<Comment>> getComments(String postId) async {
    try {
      return await remoteDataSource.getComments(postId);
    } catch (e) {
      throw Exception("Failed to load comments: $e");
    }
  }

  @override
  Future<Comment> addComment(String postId, String text) async {
    try {
      final newComment = await remoteDataSource.addComment(postId, text);
      // TODO: optionally update cached post with new comment
      return newComment;
    } catch (e) {
      throw Exception("Failed to add comment: $e");
    }
  }
}
