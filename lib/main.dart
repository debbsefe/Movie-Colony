import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.gr.dart';
import 'core/cache/app_cache.dart';
import 'core/utils/strings.dart';
import 'providers.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //initialize dependency injection
  await di.init();

  runApp(
    ProviderScope(
      child: MovieColony(),
    ),
  );
}

class MovieColony extends ConsumerWidget {
  MovieColony({
    Key? key,
  }) : super(key: key);

  final AppCache prefs = di.sl<AppCache>();
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);
    var isFirstTime = prefs.retrieveBool(Strings.firstTimeUser);

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MovieColony',
        theme: theme,
        routerDelegate: AutoRouterDelegate.declarative(
          _appRouter,
          routes: (_) => [
            if (isFirstTime == null)
              const OnboardingRoute()
            else
              const HomeScreenTabRoute(),
          ],
        ),
        routeInformationParser:
            _appRouter.defaultRouteParser(includePrefixMatches: true));
  }
}
