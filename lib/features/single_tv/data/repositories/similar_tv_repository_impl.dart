import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/models/tv_list/tv_list.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/similar_tv_repository.dart';
import '../datasources/similar_tv_remote_data_source.dart';

@LazySingleton(as: SimilarTvRepository)
class SimilarTvRepositoryImpl implements SimilarTvRepository {
  SimilarTvRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final SimilarTvRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<TvList>>> getSimilarTv(String id) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteSimilarTv(id);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
