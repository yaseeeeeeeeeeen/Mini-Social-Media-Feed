import '../entities/post.dart';
import '../repositories/feed_repository.dart';

class LikePost {
  final FeedRepository repository;

  LikePost(this.repository);

  Future<Post> call(String postId) async {
    return await repository.likePost(postId);
  }
}
