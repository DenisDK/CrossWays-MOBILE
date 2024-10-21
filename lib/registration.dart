import 'package:flutter/material.dart';
import 'registration.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 188, 176),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            width: 300,
            height: 500,
            decoration: const BoxDecoration(
              color:  Color.fromARGB(255, 231, 229, 225)
            ),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 90, right: 60),
                child: Text(
                   'Sign Up',
                    style: TextStyle(
                    color: Color.fromARGB(255, 135, 100, 71),
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
                ElevatedButton(
                  onPressed: () {
                    // Додайте функціональність кнопки тут
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
                      )
                    ),
                  ),
                  child: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: Color.fromARGB(255, 135, 100, 71),
                      fontSize: 13,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                ElevatedButton(
                  onPressed: () {
                    // Додайте функціональність кнопки тут
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
                      )
                    ),
                  ),
                  child: const Text(
                    'Continue with Facebook',
                    style: TextStyle(
                      color: Color.fromARGB(255, 135, 100, 71),
                      fontSize: 13,
                    ),
                  ),
                ),
              ]
            )
          ),
        ),
      )
    );
  }
}