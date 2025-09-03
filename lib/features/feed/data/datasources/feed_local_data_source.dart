import 'package:hive/hive.dart';

import '../../domain/entities/post.dart';
import '../../domain/entities/comment.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

abstract class FeedLocalDataSource {
  Future<void> cachePosts(List<Post> posts);
  Future<List<Post>> getCachedPosts();

  Future<void> cacheComments(String postId, List<Comment> comments);
  Future<List<Comment>> getCachedComments(String postId);
}

class FeedLocalDataSourceImpl implements FeedLocalDataSource {
  static const String postsBoxName = 'postsBox';
  static const String commentsBoxName = 'commentsBox';

  @override
  Future<void> cachePosts(List<Post> posts) async {
    final box = await Hive.openBox(postsBoxName);
    final postMaps = posts.map((post) => (post as PostModel).toJson()).toList();
    await box.put('cachedPosts', postMaps);
  }

  @override
  Future<List<Post>> getCachedPosts() async {
    final box = await Hive.openBox(postsBoxName);
    final postMaps = box.get('cachedPosts', defaultValue: []);
    if (postMaps is List) {
      return postMaps
          .map((p) => PostModel.fromJson(Map<String, dynamic>.from(p)))
          .toList();
    }
    return [];
  }

  @override
  Future<void> cacheComments(String postId, List<Comment> comments) async {
    final box = await Hive.openBox(commentsBoxName);
    final commentMaps =
        comments.map((c) => (c as CommentModel).toJson()).toList();
    await box.put(postId, commentMaps);
  }

  @override
  Future<List<Comment>> getCachedComments(String postId) async {
    final box = await Hive.openBox(commentsBoxName);
    final commentMaps = box.get(postId, defaultValue: []);
    if (commentMaps is List) {
      return commentMaps
          .map((c) => CommentModel.fromJson(Map<String, dynamic>.from(c)))
          .toList();
    }
    return [];
  }
}
