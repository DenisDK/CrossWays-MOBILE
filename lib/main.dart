import 'package:cross_ways/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrossWays',
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'CrossWays',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Перша кнопка'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Друга кнопка'),
          ),
        ],
      ),
    );
  }
}
