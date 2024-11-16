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
    'Subscribe?',
    'Are you sure you want to add this user to your subscriptions?',
  );

  if (result != null && result) {
    try {
      final currentUserDoc = await users.doc(currentUserId).get();
      final currentUserData = currentUserDoc.data() as Map<String, dynamic>;

      final List<dynamic> currentUserTravelCompanions =
          List.from(currentUserData['travelCompanions'] ?? []);
      final bool isPremium = currentUserData['isPremium'] ?? false;

      if (currentUserTravelCompanions.contains(subscriberId)) {
        CustomAlert.show(
          context: context,
          title: 'Already subscribed',
          content: 'You are already subscribed to this user.',
          buttonText: 'OK',
        );
        return;
      }

      if (!isPremium && currentUserTravelCompanions.length >= 10) {
        CustomAlert.show(
          context: context,
          title: 'Limit reached',
          content:
              'You can only have up to 10 subscriptions. Upgrade to premium to add more.',
          buttonText: 'OK',
        );
        return;
      }

      currentUserTravelCompanions.add(subscriberId);
      await users
          .doc(currentUserId)
          .update({'travelCompanions': currentUserTravelCompanions});

      CustomAlert.show(
        context: context,
        title: 'Success',
        content: 'You have successfully subscribed!',
        buttonText: 'OK',
      );
    } catch (e) {
      CustomAlert.show(
        context: context,
        title: 'Error',
        content: 'An error occurred while adding the subscription: $e',
        buttonText: 'OK',
      );
    }
  }
}
