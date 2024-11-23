import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<void> createTrip(
    String country,
    DateTime from,
    DateTime to,
    String title,
    String description,
    File imageFile, // Передаємо файл зображення
    int memberLimit,
    ) async {
  try {
    // Отримати поточного користувача
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('User is not logged in');
    }

    // Завантаження зображення у Firebase Storage
    String fileName = 'trips/${currentUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    FirebaseStorage storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref(fileName).putFile(imageFile);
    String imageUrl = await snapshot.ref.getDownloadURL();

    // Отримати посилання на Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Підготувати дані для створення подорожі
    final tripData = {
      'title': title,
      'description': description,
      'from': Timestamp.fromDate(from), // Перетворення DateTime в Firestore формат
      'to': Timestamp.fromDate(to), // Перетворення DateTime в Firestore формат
      'imageUrl': imageUrl,
      'country': country,
      'memberLimit': memberLimit,
      'creatorId': currentUser.uid, // ID користувача
      'createdAt': Timestamp.now(), // Дата створення
      'status': true, // Статус подорожі
      'participants': [currentUser.uid], // Учасники подорожі
    };

    // Створити новий документ у колекції Trips
    DocumentReference tripRef = await firestore.collection('Trips').add(tripData);
    final TripCollection = FirebaseFirestore.instance.collection('Trips');
    String tripId = tripRef.id;

    await Future.wait([
      TripCollection.doc(tripId).collection('FeedbackComment').add({}),
      TripCollection.doc(tripId).collection('FeedbackStars').add({})
    ]);

    // Додати ID до масиву ActiveTrips документа поточного користувача
    await firestore.collection('Users').doc(currentUser.uid).update({
      'activeTravels': FieldValue.arrayUnion([tripId])
    });

    print('Trip created successfully with ID: $tripId');
  } catch (e) {
    print('Failed to create trip: $e');
  }
}