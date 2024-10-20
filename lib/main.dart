import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CrossWays',
      home: MyHomePage(),
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
