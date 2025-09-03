import '../entities/comment.dart';
import '../repositories/feed_repository.dart';

class AddComment {
  final FeedRepository repository;

  AddComment(this.repository);

  Future<Comment> call(String postId, String text) async {
    return await repository.addComment(postId, text);
  }
}
