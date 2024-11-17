import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkUserPrivateStatusById(String userId) async {
  try {
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    if (userDoc.exists && userDoc.data() != null) {
      return userDoc['isPrivate'] ?? false;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
