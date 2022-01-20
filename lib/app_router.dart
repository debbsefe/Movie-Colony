import 'package:auto_route/auto_route.dart';

import 'features/auth/presentation/screens/signup_page.dart';
import 'features/homescreen/presentation/screens/homescreen.dart';
import 'features/homescreen/presentation/screens/homescreen_tab.dart';
import 'features/homescreen/presentation/screens/settings_page.dart';
import 'features/notification/presentation/screens/notification_list_screen.dart';
import 'features/onboarding/presentation/onboarding.dart';
import 'features/single_tv/presentation/screens/single_tv_detail.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page Screen Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/onboarding',
      page: Onboarding,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/signup',
      page: SignUpPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/',
      page: HomeScreenTab,
      children: [
        AutoRoute(
          name: 'HomeScreenRouter',
          path: '',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: HomeScreen),
            AutoRoute(path: 'trending/tv/:id', page: SingleTvDetail),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          name: 'SearchRouter',
          path: 'search',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: Search),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          name: 'NotificationListRouter',
          path: 'notification-list',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: NotificationListScreen),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          name: 'SettingsRouter',
          path: 'settings',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SettingsPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
