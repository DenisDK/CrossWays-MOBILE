// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBFi_QQtQMmHSSbUPzei8aPWU-N9IOH3hw',
    appId: '1:644552172787:web:9a74fde2127c14a4c24386',
    messagingSenderId: '644552172787',
    projectId: 'cross-ways',
    authDomain: 'cross-ways.firebaseapp.com',
    storageBucket: 'cross-ways.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0hrqQAAfDiBG-3_gPqtrzaRJXUEaa-rI',
    appId: '1:644552172787:android:def500807674d4c5c24386',
    messagingSenderId: '644552172787',
    projectId: 'cross-ways',
    storageBucket: 'cross-ways.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1aVMMnf2bsibJwiuosn3BKOak4_YGfCY',
    appId: '1:644552172787:ios:641bea7930f2502bc24386',
    messagingSenderId: '644552172787',
    projectId: 'cross-ways',
    storageBucket: 'cross-ways.appspot.com',
    iosBundleId: 'com.example.crossWays',
  );
}
