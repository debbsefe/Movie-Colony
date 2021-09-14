import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/anonymous_sign_in_repository.dart';

@LazySingleton()
class SignInAnonymous extends UseCase<void, NoParams> {
  SignInAnonymous(this.repository);

  final AnonymousSignInRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.anonymousSignInAuth();
  }
}
