import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_reader/constants.dart';
import 'package:qr_reader/WellcomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Cap App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gLightPrimaryColor,
        accentColor: gAccentColor,
      ),
      home: WellcomePage(),
    );
  }
}