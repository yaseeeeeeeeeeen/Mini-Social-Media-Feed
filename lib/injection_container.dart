import 'package:get_it/get_it.dart';

import 'features/feed/data/datasources/feed_remote_data_source.dart';
import 'features/feed/data/datasources/feed_local_data_source.dart';
import 'features/feed/data/repositories/feed_repository_impl.dart';
import 'features/feed/domain/repositories/feed_repository.dart';
import 'features/feed/domain/usecases/get_posts.dart';
import 'features/feed/domain/usecases/like_post.dart';
import 'features/feed/presentation/bloc/feed_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => FeedBloc(getPosts: sl(), likePost: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPosts());
  sl.registerLazySingleton(() => LikePost());

  // Repository
  sl.registerLazySingleton<FeedRepository>(
    () => FeedRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<FeedRemoteDataSource>(
    () => FeedRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<FeedLocalDataSource>(
    () => FeedLocalDataSourceImpl(),
  );
}
