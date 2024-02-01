import 'package:ciphat/routes/routes.dart';
import 'package:ciphat/shared/shared.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final HelperFunctions _helperfunctions = HelperFunctions();
  @override
  void initState() {
    super.initState();
    // _helperfunctions.startHelp();
    // if(_helperfunctions.isSplash) {
    //   _helperfunctions.isSplash = false;
    //   nextScreenReplace(context, '/temp');
    // }else{
    //   nextScreenReplace(context, '/mainpage');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: const Text(
           'Root Page'
         ),
        ),
      body: const Row(
        children: [
          Text("Hello")
        ],
      ),
    );
  }
}
