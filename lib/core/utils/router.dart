import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman_client/ui/screens/home_screen.dart';
import 'package:kamera_teman_client/ui/screens/login_screen.dart';
import 'package:kamera_teman_client/ui/screens/register_screen.dart';

class RouteName {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String login = 'login';
  static const String register = 'register';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteName.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
