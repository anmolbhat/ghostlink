import 'dart:async';
import 'package:flutter/services.dart';
import 'package:ciphat/pages/pages.dart';
import 'package:ciphat/pages/splash_page.dart';
import 'package:ciphat/routes/providers.dart';
import 'package:ciphat/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ciphat/shared/shared.dart';
import 'package:provider/provider.dart';
import 'services/firebase/firebase_options.dart';
Future<void> main() async{
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Constants().primaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        // home: const SplashPage(),
        initialRoute: AppRoutes.mainpage,
        routes: AppRoutes.getRoutes(),
        // initialRoute: AppPages.INITIAL,
        // getPages: AppPages.routes,
      ),
    );
  }
}
