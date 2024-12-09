import 'package:cloud_firestore/cloud_firestore.dart';

Future<double> calculateAverageRating(String userId) async {
  try {
    // Посилання на підколекцію FeedbackStart для вказаного користувача
    CollectionReference feedbackCollection = FirebaseFirestore.instance
        .collection('Users') // Основна колекція
        .doc(userId) // Документ користувача
        .collection('FeedbackStars'); // Підколекція

    // Отримання всіх документів з підколекції
    QuerySnapshot feedbackSnapshot = await feedbackCollection.get();

    if (feedbackSnapshot.docs.isEmpty) {
      // Якщо немає відгуків, повертаємо 0
      return 0.0;
    }

    // Підрахунок загальної кількості зірок
    int totalStars = 0;

    for (var doc in feedbackSnapshot.docs) {
      totalStars += (doc['stars'] as int);
    }

    // Обчислення середнього значення
    double averageRating = totalStars / feedbackSnapshot.docs.length;

    // Повернення числа з 2 цифрами після коми
    return double.parse(averageRating.toStringAsFixed(2));
  } catch (e) {
    print('Помилка при обчисленні середньої оцінки: $e');
    return 0.0;
  }
}
