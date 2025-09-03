import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_media/features/feed/domain/usecases/add_comment.dart';
import 'package:mini_social_media/features/feed/domain/usecases/get_comments.dart';
import 'package:mini_social_media/features/feed/domain/usecases/get_posts.dart';
import 'package:mini_social_media/features/feed/domain/usecases/like_post.dart';


import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPosts getPosts;
  final LikePost likePost;
  final GetComments getComments;
  final AddComment addComment;

  FeedBloc({
    required this.getPosts,
    required this.likePost,
    required this.getComments,
    required this.addComment,
  }) : super(FeedInitial()) {
    on<FeedFetched>(_onFeedFetched);
    on<PostLiked>(_onPostLiked);
    on<CommentsRequested>(_onCommentsRequested);
    on<CommentAdded>(_onCommentAdded);
  }

  Future<void> _onFeedFetched(
    FeedFetched event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    try {
      final posts = await getPosts(event.page);
      emit(FeedLoaded(posts: posts, hasReachedMax: posts.isEmpty));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onPostLiked(PostLiked event, Emitter<FeedState> emit) async {
    try {
      final updatedPost = await likePost(event.postId);
      if (state is FeedLoaded) {
        final current = (state as FeedLoaded).posts;
        final newPosts =
            current
                .map((p) => p.id == updatedPost.id ? updatedPost : p)
                .toList();
        emit(FeedLoaded(posts: newPosts));
      }
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onCommentsRequested(
    CommentsRequested event,
    Emitter<FeedState> emit,
  ) async {
    try {
      final comments = await getComments(event.postId);
      emit(CommentsLoaded(event.postId, comments));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onCommentAdded(
    CommentAdded event,
    Emitter<FeedState> emit,
  ) async {
    try {
      final newComment = await addComment(event.postId, event.text);
      emit(CommentAddedSuccess(newComment));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }
}
