import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addFeedback(String targetUserId, int stars) async {
  try {
    // Отримання поточного користувача з Firebase Auth
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('Помилка: Користувач не авторизований');
      return;
    }

    String currentUserId = currentUser.uid; // ID поточного користувача

    // Отримання посилання на підколекцію FeedbackStart
    CollectionReference feedbackCollection = FirebaseFirestore.instance
        .collection('Users') // Основна колекція
        .doc(targetUserId) // Документ користувача, якому ставлять бал
        .collection('FeedbackStars'); // Підколекція

    // Створення нового документа в підколекції
    await feedbackCollection.add({
      'userID': currentUserId, // ID поточного користувача
      'stars': stars, // Кількість зірок
    });

    print('Відгук успішно додано');
  } catch (e) {
    print('Помилка при додаванні відгуку: $e');
  }
}
