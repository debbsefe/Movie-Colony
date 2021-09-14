import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/google_sign_in_repository.dart';
import '../datasources/google_sign_in_remote_data_source.dart';

@LazySingleton(as: GoogleSignInRepository)
class GoogleSignInRepositoryImpl implements GoogleSignInRepository {
  GoogleSignInRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final GoogleSignInRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> googleSignInAuth() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remote = await remoteDataSource.signInWithGoogle();
        return Right(remote);
      } on ServerException {
        return const Left(
            ServerFailure(message: 'Something went wrong, please try again'));
      } on ConflictException {
        return const Left(ConflictFailure(message: 'Account already exists'));
      } on InvalidException {
        return const Left(InvalidFailure(message: 'Invalid details'));
      }
    } else {
      return const Left(CacheFailure(message: 'Poor internet connection'));
    }
  }
}
