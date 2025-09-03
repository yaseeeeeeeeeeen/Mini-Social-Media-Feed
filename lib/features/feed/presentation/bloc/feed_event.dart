import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fetch posts (infinite scroll)
class FeedFetched extends FeedEvent {
  final int page;
  FeedFetched({this.page = 1});

  @override
  List<Object?> get props => [page];
}

// Like a post
class PostLiked extends FeedEvent {
  final String postId;
  PostLiked(this.postId);

  @override
  List<Object?> get props => [postId];
}

// Load comments
class CommentsRequested extends FeedEvent {
  final String postId;
  CommentsRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}

// Add a comment
class CommentAdded extends FeedEvent {
  final String postId;
  final String text;
  CommentAdded(this.postId, this.text);

  @override
  List<Object?> get props => [postId, text];
}
