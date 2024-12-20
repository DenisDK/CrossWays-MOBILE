import 'package:cross_ways/components/custom_error_alert.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


Future<User?> signInWithFacebook(BuildContext context) async {
  try {

    final result = await FacebookAuth.instance.login(
      permissions: ['public_profile'],
    );

    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken;

      if (accessToken == null) {
        CustomAlert.show(
          context: context,
          title: 'Помилка',
          content: 'Не вдалося отримати токен доступу Facebook.',
          titleColor: const Color.fromARGB(255, 135, 100, 71),
          contentColor: const Color.fromARGB(255, 135, 100, 71),
          titleFontSize: 22.0,
          contentFontSize: 18.0,
          buttonColor: const Color.fromARGB(255, 135, 100, 71),
          buttonText: 'OK',
          dialogBackgroundColor: const Color.fromARGB(255, 231, 229, 225),
        );
        return null;
      }

     final facebookAuthCredential = FacebookAuthProvider.credential(accessToken.tokenString);

      final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      return userCredential.user;

    } else if (result.status == LoginStatus.cancelled) {
      CustomAlert.show(
        context: context,
        title: 'Вхід скасовано',
        content: 'Вхід через Facebook був скасований.',
        titleColor: const Color.fromARGB(255, 135, 100, 71),
        contentColor: const Color.fromARGB(255, 135, 100, 71),
        titleFontSize: 22.0,
        contentFontSize: 18.0,
        buttonColor: const Color.fromARGB(255, 135, 100, 71),
        buttonText: 'OK',
        dialogBackgroundColor: const Color.fromARGB(255, 231, 229, 225),
      );
      return null;

    } else {
      CustomAlert.show(
        context: context,
        title: 'Помилка',
        content: 'Помилка при вході через Facebook: ${result.message}',
        titleColor: const Color.fromARGB(255, 135, 100, 71),
        contentColor: const Color.fromARGB(255, 135, 100, 71),
        titleFontSize: 22.0,
        contentFontSize: 18.0,
        buttonColor: const Color.fromARGB(255, 135, 100, 71),
        buttonText: 'OK',
        dialogBackgroundColor: const Color.fromARGB(255, 231, 229, 225),
      );
      return null;
    }

  } on FirebaseAuthException catch (e) {
    String errorMessage;
    switch (e.code) {
      case 'account-exists-with-different-credential':
        errorMessage =
            'Обліковий запис вже існує з такою ж адресою електронної пошти, але з іншими обліковими даними для входу. Увійдіть, використовуючи спосіб, пов’язаний з цією адресою електронної пошти.';
        break;
      case 'invalid-credential':
        errorMessage =
            'Неправильний обліковий запис Facebook. Спробуйте ще раз.';
        break;
      case 'user-not-found':
        errorMessage = 'Користувача не знайдено. Спробуйте ще раз.';
        break;
      default:
        errorMessage = 'Виникла помилка при вході через Facebook: ${e.message}';
    }
    CustomAlert.show(
      context: context,
      title: 'Помилка',
      content: errorMessage,
      titleColor: const Color.fromARGB(255, 135, 100, 71),
      contentColor: const Color.fromARGB(255, 135, 100, 71),
      titleFontSize: 22.0,
      contentFontSize: 18.0,
      buttonColor: const Color.fromARGB(255, 135, 100, 71),
      buttonText: 'OK',
      dialogBackgroundColor: const Color.fromARGB(255, 231, 229, 225)
    );
    return null;
  } catch (e) {
    CustomAlert.show(
      context: context,
      title: 'Помилка',
      content: 'Виникла помилка при вході через Facebook: $e',
      titleColor: const Color.fromARGB(255, 135, 100, 71),
      contentColor: const Color.fromARGB(255, 135, 100, 71),
      titleFontSize: 22.0,
      contentFontSize: 18.0,
      buttonColor: const Color.fromARGB(255, 135, 100, 71),
      buttonText: 'OK',
      dialogBackgroundColor: const Color.fromARGB(255, 231, 229, 225),
    );
    return null;
  }
}
