import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/components/custom_error_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';

Future<void> addFriend(String friendId, BuildContext context) async {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  bool? result = await CustomDialogAlert.showConfirmationDialog(
    context,
    'Add Friend',
    'Are you sure you want to add this friend?',
  );

  if (result != null && result) {
    final currentUserDoc = await users.doc(currentUserId).get();
    final currentUserTravelCompanions =
        List.from(currentUserDoc['travelCompanions'] ?? []);

    if (!currentUserTravelCompanions.contains(friendId)) {
      currentUserTravelCompanions.add(friendId);
      await users
          .doc(currentUserId)
          .update({'travelCompanions': currentUserTravelCompanions});

      CustomAlert.show(
        context: context,
        title: 'Success',
        content: 'You are now friends!',
        buttonText: 'OK',
      );
    } else {
      CustomAlert.show(
        context: context,
        title: 'Already Friends',
        content: 'You are already friends.',
        buttonText: 'OK',
      );
    }
  }
}
