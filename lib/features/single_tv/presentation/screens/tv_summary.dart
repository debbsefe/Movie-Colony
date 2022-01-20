import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/size_ext.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../providers.dart';
import '../../../notification/data/models/notification_list_model.dart';

class TvSummary extends ConsumerWidget {
  const TvSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tvDetail = ref.watch(tvDetailProvider);
    final notificationList = ref.watch(notifListStreamProvider).asData;

    return tvDetail.when(
        initial: () => Container(),
        loading: () => Container(),
        error: (e) => Text(e.toString()),
        loaded: (detail) {
          String overview = detail?.overview ?? '';
          var categories = detail?.categories ?? [];
          bool? contain = (() {
            return notificationList?.value.any((e) => e.id == detail?.id);
          })();
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plot Summary',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Height(10),
                Text(
                  overview,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 12),
                ),
                const Height(15),
                Text(
                  'Genres',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Height(15),
                Wrap(
                  spacing: 10,
                  runSpacing: 15,
                  alignment: WrapAlignment.spaceBetween,
                  children: categories.map((e) {
                    return GestureDetector(
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: CustomTheme.primaryTint5,
                            border: Border.all(
                              color: CustomTheme.primaryTint2,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Text(
                            e.name ?? '',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                    );
                  }).toList(),
                ),
                if (contain == null || !contain)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: CustomButton(
                      onPressed: () {
                        ref
                            .read(addNotificationListProvider.notifier)
                            .addNotification(
                              NotificationListModel(
                                id: detail?.id,
                                name: detail?.name,
                                rating: detail?.rating,
                                date: detail?.startDate,
                                posterImage: detail?.posterImage,
                              ),
                            );
                      },
                      name: 'Notify Me',
                    ),
                  )
              ],
            ),
          );
        });
  }
}
