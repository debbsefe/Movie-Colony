import 'package:injectable/injectable.dart';

import '../../../../../core/notifiers/generic_state_notifier.dart';
import '../../../domain/entities/tv_cast.dart';

import '../../../domain/usecases/get_tv_cast.dart';

@LazySingleton()
class TvCastNotifier extends GenericStateNotifier<List<TvCast>> {
  TvCastNotifier(this.tvCast);

  final GetTvCast tvCast;

  void fetchTvCast(String id) {
    sendRequest(() async {
      return await tvCast(Params(id: id));
    });
  }
}
