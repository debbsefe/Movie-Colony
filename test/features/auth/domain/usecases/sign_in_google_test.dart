import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_colony/core/usecases/usecase.dart';
import 'package:movie_colony/features/auth/domain/repositories/google_sign_in_repository.dart';
import 'package:movie_colony/features/auth/domain/usecases/sign_in_google.dart';

class MockGoogleSignInRepository extends Mock
    implements GoogleSignInRepository {}

void main() {
  late MockGoogleSignInRepository repository;
  late SignInGoogle usecase;
  setUp(() {
    repository = MockGoogleSignInRepository();
    usecase = SignInGoogle(repository);
  });

  test(
    'verify google sign in was called',
    () async {
      // act
      await usecase(NoParams());
      // assert
      verify(repository.googleSignInAuth());
      verifyNoMoreInteractions(repository);
    },
  );
}
