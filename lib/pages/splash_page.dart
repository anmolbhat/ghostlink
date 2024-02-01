import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../shared/utils/helperFunctions.dart';
import 'package:ciphat/routes/routes.dart';
//Splash Page
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: const FlutterLogo()
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: const Center(
                    child: Text(
                        'CipHAT',
                        style: TextStyle( fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Comfortaa',)
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SpinKitFadingCircle(color: Colors.black38,size: 91,),
        ],
      ),
    );
  }
}









