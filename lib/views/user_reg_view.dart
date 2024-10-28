import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class UserRegScreen extends StatefulWidget {
  @override
  _UserRegScreenState createState() => _UserRegScreenState();
}

class _UserRegScreenState extends State<UserRegScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 188, 188, 176),
      body: Stack(
        children: [
          // Іконка назад
          Positioned(
            top: 40, 
            left: 20,
            child: IconButton(
              icon: const Icon(
                Symbols.arrow_back_2,
                fill: 1,
                color: Color.fromARGB(255, 135, 100, 71),
                size: 32,
              ),
              onPressed: () {
                   Navigator.pushReplacement(
                              context,
                              PushPageRoute(page:const  MainMenuView()));
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 330,
                height: 460,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 229, 225),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 20),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Поле Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    // Поле Surname
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            labelText: 'Surname',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    // Поле Birthday
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Pick a date',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Color.fromARGB(255, 135, 100, 71),
                            ),
                            border: InputBorder.none,
                          ),
                          onTap: () async {
                            // Вибір дати
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor: const Color.fromARGB(255, 135, 100, 71),
                                    hintColor: const Color.fromARGB(255, 135, 100, 71),
                                    colorScheme: const ColorScheme.light(primary: Color.fromARGB(255, 135, 100, 71)),
                                    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // Кнопка Continue
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 92, 109, 103),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black45,
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
