import 'package:equatable/equatable.dart';
import 'package:mini_social_media/features/feed/domain/entities/comment.dart';
import 'package:mini_social_media/features/feed/domain/entities/post.dart';


abstract class FeedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;
  final bool hasReachedMax;

  FeedLoaded({required this.posts, this.hasReachedMax = false});

  FeedLoaded copyWith({List<Post>? posts, bool? hasReachedMax}) {
    return FeedLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [posts, hasReachedMax];
}

class FeedError extends FeedState {
  final String message;
  FeedError(this.message);

  @override
  List<Object?> get props => [message];
}

class CommentsLoaded extends FeedState {
  final String postId;
  final List<Comment> comments;

  CommentsLoaded(this.postId, this.comments);

  @override
  List<Object?> get props => [postId, comments];
}

class CommentAddedSuccess extends FeedState {
  final Comment comment;
  CommentAddedSuccess(this.comment);

  @override
  List<Object?> get props => [comment];
}
