import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart'; // Для імпорту файлів
import 'package:firebase_auth/firebase_auth.dart'; // Імпорт Firebase Auth

Future<void> addUser(String nickname, String name, String gender, DateTime birthday) async {
  final users = FirebaseFirestore.instance.collection('Users');
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;

  // Отримуємо uid поточного користувача
  final User? currentUser = auth.currentUser;

  if (currentUser == null) {
    print("Користувач не авторизований.");
    return;
  }

  final String uid = currentUser.uid;

  final querySnapshot = await users.doc(uid).get();

  if (querySnapshot.exists) {
    print("Користувач з uid '$uid' вже існує.");
    return;
  }

  try {
    // Читаємо файл з assets
    final ByteData bytes = await rootBundle.load('assets/standardImage.png');
    final Uint8List imageData = bytes.buffer.asUint8List(); // Зміна типу на Uint8List

    // Завантажуємо зображення в Firebase Storage
    final storageRef = storage.ref().child('profileImages/$nickname.png');
    await storageRef.putData(imageData);

    // Отримуємо URL зображення
    final String downloadUrl = await storageRef.getDownloadURL();

    // Додаємо користувача до Firestore під uid
    await users.doc(uid).set({
      'nickname': nickname,
      'name': name,
      'gender': gender,
      'birthday': birthday,
      'aboutMe': '',
      'travelCompanions': [],
      'travels': [],
      'activeTravels': [],
      'isPrivate': false,
      'profileImage': downloadUrl,
      'isPremium': false,
    });

  } catch (error) {
    print("Не вдалося додати користувача: $error");
    return;
  }
}
