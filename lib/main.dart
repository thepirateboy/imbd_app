import 'package:flutter/material.dart';

void main() {
  runApp(const IMBdApp());
}

class IMBdApp extends StatelessWidget {
  const IMBdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text("data"),
      ),
    );
  }
}
