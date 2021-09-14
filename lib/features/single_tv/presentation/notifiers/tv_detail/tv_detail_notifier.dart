import 'package:injectable/injectable.dart';

import '../../../../../core/notifiers/generic_state_notifier.dart';
import '../../../domain/entities/tv_detail.dart';
import '../../../domain/usecases/get_tv_detail.dart';

@LazySingleton()
class TvDetailNotifier extends GenericStateNotifier<TvDetail> {
  TvDetailNotifier(this.tvDetail);

  final GetTvDetail tvDetail;

  void fetchTvDetail(String id) {
    sendRequest(() async {
      return await tvDetail(Params(id: id));
    });
  }
}
