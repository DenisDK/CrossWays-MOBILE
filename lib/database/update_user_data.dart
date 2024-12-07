import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/generated/l10n.dart';
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
        SnackBar(content: Text(S.of(context).profileUpdatedSuccessfully)));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).errorUpdatingProfile)));
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
        SnackBar(content: Text(S.of(context).profileUpdatedSuccessfully)));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).errorUpdatingProfile)));
    log(e as String);
  }
}

Future<void> uploadAvatar(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).noFileSelected)),
    );
    return;
  }

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).userIsNotAuthorized)),
    );
    return;
  }

  final userRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);
  final userDoc = await userRef.get();

  final isPremium = userDoc.data()?['isPremium'] ?? false;

  final file = File(pickedFile.path);

  final fileSize = await file.length();
  if (fileSize > 4 * 1024 * 1024) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).fileSizeMustNotExceed4Mb)),
    );
    return;
  }

  try {
    String avatarPath;

    if (isPremium && pickedFile.name.endsWith('.gif')) {
      avatarPath = 'avatars/${user.uid}/animated_avatar.gif';
    } else if (!pickedFile.name.endsWith('.gif')) {
      avatarPath = 'profileImages/${user.uid}.jpg';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                S.of(context).animatedAvatarsAreOnlyAvailableToPremiumUsers)),
      );
      return;
    }

    final oldAvatarUrl = userDoc['profileImage'];
    if (oldAvatarUrl != null) {
      try {
        final storageRef = FirebaseStorage.instance.refFromURL(oldAvatarUrl);
        await storageRef.delete();
      } catch (e) {
        log('Error deleting old avatar: $e');
      }
    }

    final storageRef = FirebaseStorage.instance.ref().child(avatarPath);
    await storageRef.putFile(file);

    final downloadUrl = await storageRef.getDownloadURL();

    await userRef.update({'profileImage': downloadUrl});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).avatarSuccessfullyUpdated)),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).avatarUploadErrorE)),
    );
  }
}
