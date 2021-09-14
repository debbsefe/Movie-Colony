import 'package:injectable/injectable.dart';

import '../../../../core/models/tv_list/tv_list.dart';
import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_trending_daily.dart';

@LazySingleton()
class DailyTrendingNotifier extends GenericStateNotifier<List<TvList>> {
  DailyTrendingNotifier(this.dailyTrending);

  final GetDailyTrending dailyTrending;
  void fetchTrending() {
    sendRequest(() async {
      return await dailyTrending(NoParams());
    });
  }
}
