import 'package:cross_ways/auth/sing_in_with_facebook.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cross_ways/auth/sign_in_with_google.dart';
import 'package:cross_ways/views/user_reg_view.dart';
import 'package:cross_ways/database/does_user_exist_in_database.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 188, 176),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 300,
                height: 480,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 231, 229, 225)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 120, right: 85),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            color: Color.fromARGB(255, 135, 100, 71),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    ElevatedButton(
                      onPressed: () async {
                        User? user = await signInWithGoogle();
                        if (user != null) {
                          if(await checkUserExists(user.uid)){
                            Navigator.pushReplacement(
                                context,
                                PushPageRoute(page: MainMenuView()));
                          }
                          else{
                            Navigator.pushReplacement(
                                context,
                                PushPageRoute(page: UserRegScreen()));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: const Size(200, 40),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              color: Color.fromARGB(255, 92, 109, 103),
                              width: 1,
                            )),
                      ),
                      child: const Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 1,
                          color: const Color.fromARGB(255, 135, 100, 71),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 1,
                          color: const Color.fromARGB(255, 135, 100, 71),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    ElevatedButton(
                      onPressed: () async {
                        User? user = await signInWithFacebook(context);
                        if (user != null) {
                          if(await checkUserExists(user.uid)){
                            Navigator.pushReplacement(
                                context,
                                PushPageRoute(page: MainMenuView()));
                          }
                          else{
                            Navigator.pushReplacement(
                                context,
                                PushPageRoute(page: UserRegScreen()));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        fixedSize: const Size(200, 40),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              color: Color.fromARGB(255, 92, 109, 103),
                              width: 1,
                            )),
                      ),
                      child: const Text(
                        'Continue with Facebook',
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isEnglish = !isEnglish;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: const Color.fromARGB(255, 135, 100, 71),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  isEnglish ? 'EN' : 'UA',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 135, 100, 71),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
