import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> updateUserPrivateStatus() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      bool isPrivate = userDoc['isPrivate'] ?? false;

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .update({'isPrivate': !isPrivate});
    } catch (e) {
      debugPrint('Failed to update isPrivate status: $e');
    }
  }
}
