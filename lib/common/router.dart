import 'package:go_router/go_router.dart';
import 'package:todo_popper/screens/list.dart';
import 'package:todo_popper/screens/today.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: "/today",
    routes: [
      GoRoute(path: "/today", builder: (context, state) => const TodayScreen()),
      GoRoute(path: "/list", builder: (context, state) => const ListScreen())
    ],
  );

  static Uri get location {
    final RouteMatch lastMatch =
        AppRouter.router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : AppRouter.router.routerDelegate.currentConfiguration;
    return matchList.uri;
  }
}
