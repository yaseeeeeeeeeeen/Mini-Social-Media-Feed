import '../entities/comment.dart';
import '../repositories/feed_repository.dart';

class GetComments {
  final FeedRepository repository;

  GetComments(this.repository);

  Future<List<Comment>> call(String postId) async {
    return await repository.getComments(postId);
  }
}
