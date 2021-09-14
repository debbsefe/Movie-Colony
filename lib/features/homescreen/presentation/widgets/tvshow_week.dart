import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';

class TvShowOfTheWeek extends ConsumerWidget {
  const TvShowOfTheWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final trending = watch(weeklyTrendingProvider);
    var url = watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return trending.when(
        initial: () => Container(),
        loading: () => Container(),
        error: (e) => Text(e.toString()),
        loaded: (trends) {
          var trend = trends?.first;
          String posterImage = trend?.posterImage ?? '';

          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                url + posterImage,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tv show of the week',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text('About ${trend?.name ?? ''}',
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
              ),
              Text(
                trend?.overview ?? '',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                child: CustomButton(
                  onPressed: () {},
                  name: 'Notify Me',
                ),
              )
            ],
          );
        });
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
