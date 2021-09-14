import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cache/app_cache.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/entities/categories.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_local_data_source.dart';
import '../datasources/categories_remote_data_source.dart';

@LazySingleton(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl({
    required this.cache,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final AppCache cache;

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    bool hasExpired = cache.isExpired(Strings.cachedCategory);

    return await getCategoriesSwitchCase(hasExpired);
  }

  Future<Either<Failure, List<Categories>>> getCategoriesSwitchCase(
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

  Future<Either<Failure, List<Categories>>> remoteData() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteCategories();
        await localDataSource.cacheLastCategory(remote);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final local = await localDataSource.getCachedCategory();
        return Right(local);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, List<Categories>>> localData() async {
    try {
      final localCategory = await localDataSource.getCachedCategory();
      return Right(localCategory);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
