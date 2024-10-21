import 'package:flutter/material.dart';
import 'registration.dart';

class LoginScreen extends StatelessWidget {
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
                const Padding(padding: EdgeInsets.only(top: 90, right: 90),
                  child: Text(
                    'Log In',
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
                const Padding(padding: EdgeInsets.only(top: 5)),
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
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 135, 100, 71),
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(255, 135, 100, 71),
                   ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}