import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/google_sign_in_repository.dart';

@LazySingleton()
class SignInGoogle extends UseCase<void, NoParams> {
  SignInGoogle(this.repository);

  final GoogleSignInRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.googleSignInAuth();
  }
}
