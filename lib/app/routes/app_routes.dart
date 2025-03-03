import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/error_handler_screen.dart';
import '../../presentation/screens/home/home_screen.dart';

// App routes
class AppRoutes {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppRoutes._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final navNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'nav');

  static final router = GoRouter(
    initialLocation: '/home',
    navigatorKey: rootNavigatorKey,
    errorBuilder: (context, state) => ErrorScreen(
      errorMessage: state.error?.message,
    ),
    routes: [
      _home,
      _error,
    ],
  );

  static final _error = GoRoute(
    path: '/error',
    builder: (context, state) {
      return ErrorScreen(
        errorDetails: state.extra as FlutterErrorDetails?,
      );
    },
  );

  static final _home = GoRoute(
    path: '/home',
    builder: (context, state) {
      return const HomeScreen();
    },
  );
}
