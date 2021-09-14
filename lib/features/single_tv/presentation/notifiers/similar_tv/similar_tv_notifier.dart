import 'package:injectable/injectable.dart';

import '../../../../../core/models/tv_list/tv_list.dart';
import '../../../../../core/notifiers/generic_state_notifier.dart';

import '../../../domain/usecases/get_similar_tv.dart';

@LazySingleton()
class SimilarTvNotifier extends GenericStateNotifier<List<TvList>> {
  SimilarTvNotifier(this.similarTv);

  final GetSimilarTv similarTv;

  void fetchSimilarTv(String id) {
    sendRequest(() async {
      return await similarTv(Params(id: id));
    });
  }
}
