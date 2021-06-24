import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/failure.dart';
import '../utils/strings.dart';
import 'generic_state.dart';

class GenericStateNotifier<T> extends StateNotifier<GenericState<T>> {
  GenericStateNotifier() : super(const GenericState.initial());

  Future<GenericState<T>> sendRequest(
      Future<Either<Failure, T>> Function() function) async {
    state = GenericState<T>.loading();
    final response = await function();
    return response.fold(
        (failure) => state = GenericState<T>.error(failure.message == null
            ? mapFailureToMessage(failure)
            : failure.message!),
        (success) => state = GenericState<T>.loaded(success));
  }
}
