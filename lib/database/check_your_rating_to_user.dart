import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<int> getUserFeedbackForTarget(String targetUserId) async {
  try {
    // Отримуємо ID поточного користувача
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("Користувач не авторизований");
    }
    String currentUserId = currentUser.uid;

    // Отримуємо колекцію FeedbackStars для перевірки
    final feedbackCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(targetUserId)
        .collection('FeedbackStars');

    // Шукаємо відгук, де userID відповідає поточному користувачу
    final querySnapshot = await feedbackCollection
        .where('userID', isEqualTo: currentUserId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Якщо відгук знайдено, повертаємо кількість зірочок
      final feedbackDoc = querySnapshot.docs.first;
      return feedbackDoc['stars'] ?? 0;
    } else {
      // Якщо відгук не знайдено, повертаємо 0
      return 0;
    }
  } catch (e) {
    print("Помилка під час перевірки відгуків: $e");
    return 0; // У випадку помилки повертаємо 0
  }
}
