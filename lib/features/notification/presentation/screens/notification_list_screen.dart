import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app_router.gr.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationList = ref.watch(notifListStreamProvider);
    var url = ref.watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return notificationList.when(
        loading: () => Container(),
        error: (e, stack) => Text(e.toString()),
        data: (notification) {
          var tv = notification;
          return Scaffold(
            body: SafeArea(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: tv.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var singleTv = tv[index];
                    String posterImage = singleTv.posterImage ?? '';

                    return Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.pushRoute(SingleTvDetailRoute(
                                id: singleTv.id.toString(),
                              ));
                            },
                            child: CachedImage(
                              url + posterImage,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ),
                          Text(
                            singleTv.name ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
