import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/tv_cast.dart';
import '../../domain/repositories/tv_cast_repository.dart';
import '../datasources/tv_cast_remote_data_source.dart';

@LazySingleton(as: TvCastRepository)
class TvCastRepositoryImpl implements TvCastRepository {
  TvCastRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final TvCastRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<TvCast>>> getTvCast(String id) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.getRemoteTvCast(id);
        return Right(remote);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
