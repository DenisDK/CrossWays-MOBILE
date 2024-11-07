import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> updateProfileNameUsername(
  BuildContext context,
  String? name,
  String? username,
) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final userRef = FirebaseFirestore.instance.collection('Users').doc(userId);
    if (name != null) {
      await userRef.update({
        'name': name,
      });
    }
    if (username != null) {
      await userRef.update({
        'nickname': username,
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Error updating profile")));
    log(e as String);
  }
}

Future<void> updateProfileAbout(BuildContext context, String? about) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final userRef = FirebaseFirestore.instance.collection('Users').doc(userId);
    await userRef.update({
      'aboutMe': about,
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")));
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Error updating profile")));
    log(e as String);
  }
}

Future<void> uploadAvatar(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    return;
  }

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final userRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);
  final userDoc = await userRef.get();

  final oldAvatarUrl = userDoc['profileImage'];
  if (oldAvatarUrl != null) {
    try {
      // Видалення старого аватара з Firebase Storage
      final storageRef = FirebaseStorage.instance.refFromURL(oldAvatarUrl);
      await storageRef.delete();
    } catch (e) {
      log('Error deleting old avatar: $e');
    }
  }

  try {
    final storageRef =
        FirebaseStorage.instance.ref().child('profileImages/${user.uid}.jpg');
    await storageRef.putFile(File(pickedFile.path));

    String avatarUrl = await storageRef.getDownloadURL();

    await userRef.update({
      'profileImage': avatarUrl,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Avatar updated successfully!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to upload avatar.')),
    );
  }
}
