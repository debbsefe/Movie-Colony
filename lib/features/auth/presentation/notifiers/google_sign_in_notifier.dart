import 'package:injectable/injectable.dart';

import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/sign_in_google.dart';

@LazySingleton()
class GoogleSignInNotifier extends GenericStateNotifier<void> {
  GoogleSignInNotifier(this.usecase);

  final SignInGoogle usecase;

  void signInWithGoogle() {
    sendRequest(() async {
      return await usecase(NoParams());
    });
  }
}
