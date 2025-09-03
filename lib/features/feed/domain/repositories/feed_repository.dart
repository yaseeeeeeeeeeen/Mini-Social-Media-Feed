import '../entities/post.dart';
import '../entities/comment.dart';

abstract class FeedRepository {
  Future<List<Post>> getPosts(int page);
  Future<Post> likePost(String postId);
  Future<List<Comment>> getComments(String postId);
  Future<Comment> addComment(String postId, String text);
}
