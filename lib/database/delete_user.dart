import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteUserFromDatabase() async {
  final users = FirebaseFirestore.instance.collection('Users');
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;

  // Отримуємо поточного користувача
  final User? currentUser = auth.currentUser;

  if (currentUser == null) {
    print("Користувач не авторизований.");
    return;
  }

  final String uid = currentUser.uid;

  try {
    // Отримуємо посилання на документ користувача
    final DocumentSnapshot userDoc = await users.doc(uid).get();

    if (!userDoc.exists) {
      print("Користувач з uid '$uid' не знайдений.");
      return;
    }

    // Видаляємо зображення користувача з Firebase Storage
    final String? profileImageUrl = userDoc.get('profileImage');
    if (profileImageUrl != null) {
      final Reference imageRef = storage.refFromURL(profileImageUrl);
      await imageRef.delete();
    }

    // Видаляємо підколекції 'FeedbackComment' та 'FeedbackStars'
    final feedbackCommentSnapshot =
    await users.doc(uid).collection('FeedbackComment').get();
    final feedbackStarsSnapshot =
    await users.doc(uid).collection('FeedbackStars').get();

    for (var doc in feedbackCommentSnapshot.docs) {
      await doc.reference.delete();
    }

    for (var doc in feedbackStarsSnapshot.docs) {
      await doc.reference.delete();
    }

    // Видаляємо документ користувача з Firestore
    await users.doc(uid).delete();

    print("Користувач успішно видалений.");
  } catch (error) {
    print("Не вдалося видалити користувача: $error");
  }
}
