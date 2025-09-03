import 'package:get_it/get_it.dart';
import 'package:mini_social_media/features/feed/domain/usecases/add_comment.dart';
import 'package:mini_social_media/features/feed/domain/usecases/get_comments.dart';

import 'features/feed/domain/usecases/get_posts.dart';
import 'features/feed/domain/usecases/like_post.dart';
import 'features/feed/presentation/bloc/feed_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
sl.registerFactory(
    () => FeedBloc(
      getPosts: sl(),
      likePost: sl(),
      getComments: sl(),
      addComment: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => LikePost(sl()));
  sl.registerLazySingleton(() => GetComments(sl()));
  sl.registerLazySingleton(() => AddComment(sl()));

}
