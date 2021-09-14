import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie_colony/service_locator.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

@injectableInit
Future<void> init(String environment) async =>
    $initGetIt(sl, environment: environment);

@Injectable()
@module
abstract class ThirdPartyServicesModule {
  //! External

  @LazySingleton(env: [Environment.prod])
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @LazySingleton()
  FirebaseAuth get dio => FirebaseAuth.instance;

  @LazySingleton()
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @LazySingleton()
  GoogleSignIn get googleSignIn => GoogleSignIn();

  @LazySingleton()
  GoogleAuthProvider get googleAuthProvider => GoogleAuthProvider();

  @LazySingleton()
  // @factoryMethod
  http.Client get client => http.Client();
}
