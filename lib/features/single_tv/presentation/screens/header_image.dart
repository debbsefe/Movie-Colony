import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/date_parser.dart';
import '../../../../core/utils/size_ext.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';

class HeaderImage extends ConsumerWidget {
  const HeaderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tvDetail = watch(tvDetailProvider);
    var url = watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return tvDetail.when(
        initial: () => Height(MediaQuery.of(context).size.height * 0.55),
        loading: () => Height(MediaQuery.of(context).size.height * 0.55),
        error: (e) => Text(e.toString()),
        loaded: (detail) {
          String posterImage = detail?.posterImage ?? '';
          String name = detail?.name ?? '';

          return Column(
            children: [
              Hero(
                tag: 'imageHero-${url + posterImage}',
                child: CachedImage(
                  url + posterImage,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              yearFromDateString(detail?.startDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: CustomTheme.greyColor3),
                            ),
                            const Width(10),
                            Text(
                              fetchSeason(
                                detail?.seasons,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: CustomTheme.greyColor3),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: CustomTheme.yellowStar,
                            ),
                            const Width(5),
                            Text(
                              detail?.rating.toString() ?? '',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: CustomTheme.primaryTint4,
                thickness: 0.75,
              )
            ],
          );
        });
  }
}

String fetchSeason(int? value) {
  return value == null
      ? ''
      : value > 1
          ? '$value Seasons'
          : '$value Season';
}
