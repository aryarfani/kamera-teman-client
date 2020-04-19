import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamera_teman_client/ui/screens/chat_screen.dart';
import 'package:kamera_teman_client/ui/screens/home_screen.dart';
import 'package:kamera_teman_client/ui/screens/keranjang_screen.dart';
import 'package:kamera_teman_client/ui/screens/location_screen.dart';
import 'package:kamera_teman_client/ui/screens/login_screen.dart';
import 'package:kamera_teman_client/ui/screens/register_screen.dart';
import 'package:kamera_teman_client/ui/screens/splash_screen.dart';

class RouteName {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String login = 'login';
  static const String register = 'register';
  static const String keranjang = 'keranjang';
  static const String lokasi = 'lokasi';
  static const String chat = 'chat';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteName.lokasi:
        return MaterialPageRoute(builder: (_) => LocationScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteName.chat:
        return CupertinoPageRoute(builder: (_) => ChatScreen());
      case RouteName.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case RouteName.keranjang:
        return CupertinoPageRoute(builder: (_) => KeranjangScreen());
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
