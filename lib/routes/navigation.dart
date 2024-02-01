import 'package:flutter/material.dart';

void nextScreenPush(context, page){
  Navigator.pushNamed(context, page);
}
void nextScreenReplace(context, page){
  Navigator.pushReplacementNamed(context, page);
}

void nextScreenPopUntilReplace(context, page){
  Navigator.popUntil(context, ModalRoute.withName('/'));
  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (Route route) => false);
}
