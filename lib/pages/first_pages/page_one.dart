import 'dart:isolate';

import 'package:ciphat/pages/pages.dart';
import 'package:ciphat/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ciphat/shared/shared.dart';
class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 400),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text("SECURE"),
              const SizedBox(height: 15,),
              SizedBox(
                height: 50,
                width: 125,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[800],
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    onPressed: () async{
                      await Storage.updateCheckFirstRun();
                      nextScreenReplace(context, "/login");
                      },
                    child: const Text("Login",style: TextStyle(color: Colors.white, fontSize: 20.00) ,)
                ),
              ),
              SizedBox(
                height: 50,
                width: 125,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[800],
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )
                    ),
                    onPressed: () async{
                      Isolate.spawn((message) { }, RSAGeneration(email: "anmolbhat@gmail.com", password: "12345678").generateMyRSAKeyPairs());

                    },
                    child: const Text("Generate",style: TextStyle(color: Colors.white, fontSize: 20.00) ,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
