import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imbd_app/Screens/InputScreen.dart';
import 'package:imbd_app/Screens/ResultScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IMBdApp());
}

class IMBdApp extends StatelessWidget {
  const IMBdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        InputScreen.id: (context) => InputScreen(),
        ResultScreen.id: (context) => ResultScreen(),
      },
      initialRoute: InputScreen.id,
    );
  }
}
