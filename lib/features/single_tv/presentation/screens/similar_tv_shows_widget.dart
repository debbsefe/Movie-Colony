import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/cache_image.dart';
import '../../../../providers.dart';
import '../../../single_tv/presentation/screens/single_tv_detail.dart';

class SimilarTvShowsWidget extends ConsumerWidget {
  const SimilarTvShowsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final similarTV = watch(similarTvProvider);
    var url = watch(configurationProvider.notifier).fetchPosterSizeUrl();

    return similarTV.when(
        initial: () => Container(),
        loading: () => Container(),
        error: (e) => Text(e.toString()),
        loaded: (similar) {
          var tv = similar ?? [];
          return ListView.builder(
              scrollDirection: Axis.horizontal,
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
                          Get.to(
                            () => SingleTvDetail(
                              id: singleTv.id.toString(),
                            ),
                          );
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
              });
        });
  }
}

///TODO:NICE PLACEHOLDER AS LOADING SCREEN
