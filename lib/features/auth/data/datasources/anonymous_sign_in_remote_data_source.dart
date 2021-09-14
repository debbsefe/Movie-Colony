import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AnonymousSignInRemoteDataSource {
  Future<void> signInAnonymous();
}

@LazySingleton(as: AnonymousSignInRemoteDataSource)
class AnonymousSignInRemoteDataSourceImpl
    extends AnonymousSignInRemoteDataSource {
  AnonymousSignInRemoteDataSourceImpl({
    required this.auth,
  });
  final FirebaseAuth auth;

  @override
  Future<void> signInAnonymous() async {
    await auth.signInAnonymously();
  }
}
