import 'package:cross_ways/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 135, 100, 71),
          selectionColor: Color.fromARGB(100, 135, 100, 71), 
          selectionHandleColor: Color.fromARGB(255, 135, 100, 71), 
        )
     
    ));
  }
}

