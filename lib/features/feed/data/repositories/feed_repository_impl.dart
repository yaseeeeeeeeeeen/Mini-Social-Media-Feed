import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_source.dart';
import '../datasources/feed_local_data_source.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;
  final FeedLocalDataSource localDataSource;

  FeedRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
}
