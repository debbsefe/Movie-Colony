import 'package:injectable/injectable.dart';

import '../../../../core/models/tv_list/tv_list.dart';
import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_trending_weekly.dart';

@LazySingleton()
class WeeklyTrendingNotifier extends GenericStateNotifier<List<TvList>> {
  WeeklyTrendingNotifier(this.weeklyTrending);

  final GetWeeklyTrending weeklyTrending;

  void fetchTrending() {
    sendRequest(() async {
      return await weeklyTrending(NoParams());
    });
  }
}
