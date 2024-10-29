import 'package:cloud_firestore/cloud_firestore.dart';

// перевірка чи є користувач в базі даних
Future<bool> checkUserExists(String userId) async {
  var collection = FirebaseFirestore.instance.collection('Users');
  var doc = await collection.doc(userId).get();
  return doc.exists;
}