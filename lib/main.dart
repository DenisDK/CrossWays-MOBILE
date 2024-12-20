import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/generated/l10n.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:cross_ways/views/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 135, 100, 71),
          selectionColor: Color.fromARGB(100, 135, 100, 71),
          selectionHandleColor: Color.fromARGB(255, 135, 100, 71),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final user = snapshot.data;
          if (user != null) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user.uid)
                  .get(),
              builder: (context, userDataSnapshot) {
                if (userDataSnapshot.connectionState == ConnectionState.done) {
                  if (userDataSnapshot.data != null &&
                      userDataSnapshot.data!.exists &&
                      userDataSnapshot.data!['nickname'] != null) {
                    return const MainMenuView();
                  } else {
                    return LogInScreen();
                  }
                }
                return _loadingScreen();
              },
            );
          } else {
            return LogInScreen();
          }
        }
        return _loadingScreen();
      },
    );
  }

  Widget _loadingScreen() {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 188, 188, 176),
      body: Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 62, 66, 68)),
        ),
      ),
    );
  }
}
