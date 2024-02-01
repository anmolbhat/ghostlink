import 'dart:async';

import 'package:ciphat/pages/splash_page.dart';
import 'package:ciphat/shared/shared.dart';
import 'package:ciphat/pages/pages.dart';
import 'package:flutter/material.dart';
//Main Page
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  final HelperFunctions _helperFunctions = HelperFunctions();
  bool isNotFirstLaunch = false;
  bool isLoggedIn = false;
  bool isSplash = true;
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isSplash = false;
      });
    });
    _helperFunctions.startHelp();
  }
  @override
  Widget build(BuildContext context) {
    isNotFirstLaunch = _helperFunctions.isNotFirstLaunch;
    isLoggedIn = _helperFunctions.isLoggedIn;
    print(isSplash);
    return Scaffold(
      body: isSplash ? const SplashPage() : isLoggedIn ? const HomePage() : isNotFirstLaunch ? const LoginPage() : const PageOne(),
    );
  }
}
