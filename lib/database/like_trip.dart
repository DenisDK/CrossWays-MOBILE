import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUserToTripRequests(String tripId, String userId) async {
  try {
    final tripRef = FirebaseFirestore.instance.collection('Trips').doc(tripId);

    // Оновлення поля requests
    await tripRef.update({
      'requests': FieldValue.arrayUnion([userId]), // Додає userId, якщо його ще немає
    });

    log('User $userId added to trip $tripId requests');
  } catch (e) {
    log('Error adding user to trip requests: $e');
  }
}