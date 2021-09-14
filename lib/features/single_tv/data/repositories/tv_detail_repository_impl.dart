import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_detail_repository.dart';
import '../datasources/tv_detail_remote_data_source.dart';

@LazySingleton(as: TvDetailRepository)
class TvDetailRepositoryImpl implements TvDetailRepository {
  TvDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final TvDetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(String id) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteTvDetail(id);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
