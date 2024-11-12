import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/components/custom_error_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';

Future<void> addSubscription(String subscriberId, BuildContext context) async {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  bool? result = await CustomDialogAlert.showConfirmationDialog(
    context,
    'Subscribe ?',
    'Are you sure you want to add this user to your subscriptions ?',
  );

  if (result != null && result) {
    final currentUserDoc = await users.doc(currentUserId).get();
    final currentUserTravelCompanions =
        List.from(currentUserDoc['travelCompanions'] ?? []);

    if (!currentUserTravelCompanions.contains(subscriberId)) {
      currentUserTravelCompanions.add(subscriberId);
      await users
          .doc(currentUserId)
          .update({'travelCompanions': currentUserTravelCompanions});

      CustomAlert.show(
        context: context,
        title: 'Success',
        content: 'You are now have subscriptions!',
        buttonText: 'OK',
      );
    } else {
      CustomAlert.show(
        context: context,
        title: 'Already subscribe',
        content: 'You are already subscribe.',
        buttonText: 'OK',
      );
    }
  }
}
