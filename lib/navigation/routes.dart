import 'package:flutter/material.dart';
import 'package:order_tracker/screens/home/home.dart';
import 'package:order_tracker/screens/login/email_login.dart';
import 'package:order_tracker/screens/login/email_signup_view.dart';
import 'package:order_tracker/screens/login/login.dart';
import 'package:order_tracker/screens/profile/profile.dart';
import 'package:order_tracker/screens/track_order/track_order.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
  ) {
    final routeName = settings.name;
    final builder = getRouteWidget(settings)[routeName];
    if (builder != null) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
      );
    } else {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('PAGE NOT FOUND'),
          ),
        ),
        settings: settings,
      );
    }
  }

  /// Returns a map of all the routes in the app.
  static Map<String, WidgetBuilder> getRouteWidget(RouteSettings settings) => {
        '/login': (_) => const LoginScreen(),
        '/email_login': (_) => const EmailLogin(),
        '/email_signup': (_) => const EmailSignupView(),
        '/home': (_) => const HomeScreen(),
        '/track_order': (_) => const TrackOrderScreen(),
        '/profile': (_) => const ProfileScreen(),
      };
}
