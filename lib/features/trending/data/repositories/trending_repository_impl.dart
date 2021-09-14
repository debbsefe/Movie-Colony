import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/models/tv_list/tv_list.dart';
import '../../../../core/models/tv_list/tv_list_model.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/trending_repository.dart';
import '../datasources/trending_local_data_source.dart';
import '../datasources/trending_remote_data_source.dart';

enum TimeWindow { weekly, daily }

@LazySingleton(as: TrendingRepository)
class TrendingRepositoryImpl implements TrendingRepository {
  TrendingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final TrendingRemoteDataSource remoteDataSource;
  final TrendingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<TvList>>> getTrendingWeekly() async {
    bool isConnected = await networkInfo.isConnected;

    return await getTrendingSwitchCase(isConnected, TimeWindow.weekly);
  }

  @override
  Future<Either<Failure, List<TvList>>> getTrendingDaily() async {
    bool isConnected = await networkInfo.isConnected;

    return await getTrendingSwitchCase(isConnected, TimeWindow.daily);
  }

  Future<Either<Failure, List<TvList>>> getTrendingSwitchCase(
      bool isConnected, TimeWindow timeWindow) async {
    switch (isConnected) {
      case true:
        return await remoteData(timeWindow);
      case false:
        return await localData(timeWindow);
      default:
        return await remoteData(timeWindow);
    }
  }

  Future<Either<Failure, List<TvList>>> remoteData(
      TimeWindow timeWindow) async {
    try {
      late List<TvListModel> _remote;
      if (timeWindow == TimeWindow.daily) {
        _remote = await remoteDataSource.getRemoteTrendingDaily();
        await localDataSource.cacheLastTrendingDaily(_remote);
      } else {
        _remote = await remoteDataSource.getRemoteTrendingWeekly();
        await localDataSource.cacheLastTrendingWeekly(_remote);
      }
      return Right(_remote);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<TvList>>> localData(TimeWindow timeWindow) async {
    try {
      late List<TvListModel> _local;
      if (timeWindow == TimeWindow.daily) {
        _local = await localDataSource.getCachedTrendingDaily();
      } else {
        _local = await localDataSource.getCachedTrendingWeekly();
      }

      return Right(_local);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
