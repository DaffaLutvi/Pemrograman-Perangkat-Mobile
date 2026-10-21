import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/splash_screen.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const detail = '/detail';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    home: (_) => const HomeScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final package = settings.arguments;
      if (package is TourPackage) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => DetailScreen(package: package),
        );
      }

      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const NotFoundScreen(),
      );
    }

    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const NotFoundScreen(),
    );
  }
}
