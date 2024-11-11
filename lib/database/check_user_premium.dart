import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkUserPremiumStatus() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    return userDoc['isPremium'];
  } else {
    return false;
  }
}

Future<bool> checkUserPremiumStatusById(String userId) async {
  try {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    if (userDoc.exists && userDoc.data() != null) {
      return userDoc['isPremium'] ?? false;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
