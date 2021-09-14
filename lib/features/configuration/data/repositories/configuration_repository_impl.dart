import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cache/app_cache.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/entities/configuration.dart';
import '../../domain/repositories/configuration_repository.dart';
import '../datasources/configuration_local_data_source.dart';
import '../datasources/configuration_remote_data_source.dart';

@LazySingleton(as: ConfigurationRepository)
class ConfigurationRepositoryImpl implements ConfigurationRepository {
  ConfigurationRepositoryImpl({
    required this.cache,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final ConfigurationRemoteDataSource remoteDataSource;
  final ConfigurationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final AppCache cache;

  @override
  Future<Either<Failure, Configuration>> getConfiguration() async {
    bool hasExpired = cache.isExpired(Strings.cachedConfiguration);

    return await getConfigurationSwitchCase(hasExpired);
  }

  Future<Either<Failure, Configuration>> getConfigurationSwitchCase(
      bool hasExpired) async {
    switch (hasExpired) {
      case true:
        return await remoteData();
      case false:
        return await localData();
      default:
        return await remoteData();
    }
  }

  Future<Either<Failure, Configuration>> remoteData() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteConfiguration();
        await localDataSource.cacheLastConfiguration(remote);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final local = await localDataSource.getCachedConfiguration();
        return Right(local);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, Configuration>> localData() async {
    try {
      final local = await localDataSource.getCachedConfiguration();
      return Right(local);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
