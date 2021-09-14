import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/anonymous_sign_in_repository.dart';
import '../datasources/anonymous_sign_in_remote_data_source.dart';

@LazySingleton(as: AnonymousSignInRepository)
class AnonymousSignInRepositoryImpl implements AnonymousSignInRepository {
  AnonymousSignInRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final AnonymousSignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> anonymousSignInAuth() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final remote = await remoteDataSource.signInAnonymous();
      return Right(remote);
    } else {
      return const Left(CacheFailure(message: 'Poor internet connection'));
    }
  }
}
