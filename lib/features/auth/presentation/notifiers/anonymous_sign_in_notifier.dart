import 'package:injectable/injectable.dart';

import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/sign_in_anonymous.dart';

@LazySingleton()
class AnonymousSignInNotifier extends GenericStateNotifier<void> {
  AnonymousSignInNotifier(this.usecase);

  final SignInAnonymous usecase;

  void signInAnonymous() {
    sendRequest(() async {
      return await usecase(NoParams());
    });
  }
}
