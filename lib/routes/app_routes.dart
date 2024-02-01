import 'package:ciphat/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:ciphat/pages/pages.dart';
class AppRoutes {
  static const String root = '/root';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String mainpage = '/';
  static const String chatpage = '/chats';
  static const String homepage = '/homepage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashPage(),
      root: (context) => const RootPage(),
      login: (context) => const LoginPage(),
      chatpage: (context) => const ChatPage(),
      signup: (context) => const SignUpPage(),
      mainpage: (context) => const MainPage(),
      homepage: (context) => const HomePage(),
      // test: (context) => const LoginPage(),
      // testt: (context) => const SignUpPage(),
    };
  }
}
