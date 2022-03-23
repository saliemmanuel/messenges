import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'vue/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messages',
      theme: ThemeData(fontFamily: 'General Sans'),
      home: const HomeScreen(),
    );
  }
}
