import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers.dart';
import '../widgets/categories_widget.dart';
import '../widgets/trending_widget.dart';
import '../widgets/tvshow_week.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _callProviders();
    });
  }

  void _callProviders() {
    context.read(weeklyTrendingProvider.notifier).fetchTrending();
    context.read(dailyTrendingProvider.notifier).fetchTrending();
    context.read(categoriesProvider.notifier).fetchCategory();
    context.read(configurationProvider.notifier).fetchConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TvShowOfTheWeek(),
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 100, child: CategoriesWidget()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore what’s trending',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text('See all',
                          style: Theme.of(context).textTheme.subtitle2)
                    ],
                  ),
                ),
                Text(
                  'Popular tv shows around the world',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 400, child: TrendingWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
