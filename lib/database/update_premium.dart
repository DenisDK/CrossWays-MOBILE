import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> updateUserPremiumStatus() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
       FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .update({'isPremium': true});
      debugPrint('User isPremium status updated to true');
    } catch (e) {
      debugPrint('Failed to update isPremium status: $e');
    }
  }
}