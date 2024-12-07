import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/components/custom_error_alert.dart';
import 'package:cross_ways/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';

Future<void> addSubscription(String subscriberId, BuildContext context) async {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  bool? result = await CustomDialogAlert.showConfirmationDialog(
    context,
    S.of(context).subscribe,
    S.of(context).areYouSureYouWantToAddThisUserTo,
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
          title: S.of(context).alreadySubscribed,
          content: S.of(context).youAreAlreadySubscribedToThisUser,
          buttonText: 'OK',
        );
        return;
      }

      if (!isPremium && currentUserTravelCompanions.length >= 10) {
        CustomAlert.show(
          context: context,
          title: S.of(context).limitReached,
          content: S.of(context).youCanOnlyHaveUpTo10SubscriptionsUpgradeTo,
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
        title: S.of(context).success,
        content: S.of(context).youHaveSuccessfullySubscribed,
        buttonText: 'OK',
      );
    } catch (e) {
      CustomAlert.show(
        context: context,
        title: S.of(context).error,
        content: S.of(context).anErrorOccurredWhileAddingTheSubscriptionE,
        buttonText: 'OK',
      );
    }
  }
}
