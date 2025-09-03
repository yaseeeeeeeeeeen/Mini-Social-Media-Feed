import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_media/features/feed/domain/usecases/get_posts.dart';
import 'package:mini_social_media/features/feed/domain/usecases/like_post.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPosts getPosts;
  final LikePost likePost;

  FeedBloc({required this.getPosts, required this.likePost})
    : super(FeedInitial()) {
    on<FeedFetched>((event, emit) {
      // TODO: call getPosts usecase here later
    });
  }
}
