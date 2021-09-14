import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/domain/repositories/anonymous_sign_in_repository.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_anonymous.dart';

class MockAnonymousSignInRepository extends Mock
    implements AnonymousSignInRepository {}

void main() {
  late MockAnonymousSignInRepository repository;
  late SignInAnonymous usecase;
  setUp(() {
    repository = MockAnonymousSignInRepository();
    usecase = SignInAnonymous(repository);
  });

  test(
    'verify anonymous sign in was called',
    () async {
      // act
      await usecase(NoParams());
      // assert
      verify(repository.anonymousSignInAuth());
      verifyNoMoreInteractions(repository);
    },
  );
}
