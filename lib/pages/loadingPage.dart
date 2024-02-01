import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final String message;
  const LoadingPage({Key? key,required this.message}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        widget.message,
      ),
    );
  }
}
