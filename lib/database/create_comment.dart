import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Функція для додавання коментаря
Future<void> addFeedbackComment(String userId, String text) async {
  // Отримуємо поточного користувача
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    print('No user is currently logged in.');
    return;
  }

  // Отримуємо поточну дату
  DateTime currentDate = DateTime.now();
  String userName = '';

  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users') // Колекція користувачів
        .doc(currentUser.uid) // Документ користувача за ID
        .get();

    userName = userDoc['name'];

    print('Feedback comment added successfully.');
  } catch (e) {
    print('Error adding feedback comment: $e');
  }

  // Створюємо новий коментар
  var feedbackComment = {
    'authorId': currentUser.uid, // Ідентифікатор поточного користувача
    'authorName': userName, // Ім'я автора
    'createdAt': currentDate, // Поточна дата
    'text': text, // Текст коментаря
  };

  try {
    // Додаємо коментар до колекції FeedbackComments для користувача
    await FirebaseFirestore.instance
        .collection('Users') // Колекція користувачів
        .doc(userId) // Доки для поточного користувача
        .collection('FeedbackComment') // Колекція коментарів
        .add(feedbackComment); // Додаємо новий коментар

    print('Feedback comment added successfully.');
  } catch (e) {
    print('Error adding feedback comment: $e');
  }
}
