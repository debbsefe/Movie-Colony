import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/notifiers/generic_state.dart';
import '../../../../core/widgets/dialogs.dart';

import '../../../../providers.dart';
import 'header_image.dart';
import 'similar_tv_shows_widget.dart';
import 'top_cast.dart';
import 'tv_summary.dart';

class SingleTvDetail extends ConsumerStatefulWidget {
  const SingleTvDetail({Key? key, @PathParam('id') required this.id})
      : super(key: key);
  final String id;

  @override
  _SingleTvDetailState createState() => _SingleTvDetailState();
}

class _SingleTvDetailState extends ConsumerState<SingleTvDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _callProviders();
    });
  }

  void _callProviders() {
    ref.read(tvDetailProvider.notifier).fetchTvDetail(widget.id);

    ref.read(tvCastProvider.notifier).fetchTvCast(widget.id);
    ref.read(similarTvProvider.notifier).fetchSimilarTv(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
        provider: addNotificationListProvider,
        onChange: (context, GenericState<void>? result, _) {
          if (result is Error<void>) {
            messageDialog(
              context: context,
              onPressed: () {
                context.router.root.pop();
              },
              content: result.message,
            );
          } else if (result is Loaded<void>) {
            messageDialog(
              context: context,
              onPressed: () {
                context.router.root.pop();
              },
              content: 'Notification added',
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Back',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderImage(),
                  const TvSummary(),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      bottom: 10,
                    ),
                    child: Text(
                      'Top Cast ',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(height: 100, child: TopCast()),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      bottom: 10,
                    ),
                    child: Text(
                      'TV Shows like this',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(height: 300, child: SimilarTvShowsWidget()),
                ],
              ),
            ),
          ),
        ));
  }
}
