import '../entities/post.dart';
import '../repositories/feed_repository.dart';

class GetPosts {
  final FeedRepository repository;

  GetPosts(this.repository);

  Future<List<Post>> call(int page) async {
    return await repository.getPosts(page);
  }
}
