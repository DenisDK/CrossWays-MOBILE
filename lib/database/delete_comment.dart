import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteComment(String userId, String commentId) async {
  try {
    // Використовуємо userId та commentId для видалення коментаря
    await FirebaseFirestore.instance
        .collection('Users') // Колекція користувачів
        .doc(userId) // Знаходимо користувача по ID
        .collection('FeedbackComment') // Колекція коментарів цього користувача
        .doc(commentId) // Ідентифікатор коментаря
        .delete(); // Видаляємо документ

    print("Comment deleted successfully.");
  } catch (e) {
    print("Error deleting comment: $e");
  }
}
