import 'package:ciphat/pages/pages.dart';
import 'package:ciphat/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ciphat/shared/shared.dart';
class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: <Widget>[
          const Text("SECURE Page 2"),
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
                  nextScreenReplace(context, const LoginPage());
                },
                child: const Text("Login",style: TextStyle(color: Colors.white, fontSize: 20.00) ,)
            ),
          ),
        ],
      ),
    );
  }
}
