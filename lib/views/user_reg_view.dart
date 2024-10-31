import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'log_in_view.dart';
import 'package:cross_ways/database/create_database_with_user.dart';


class UserRegScreen extends StatefulWidget {
  @override
  _UserRegScreenState createState() => _UserRegScreenState();
}

class _UserRegScreenState extends State<UserRegScreen> {
  DateTime? birthday;
  String? selectedGender;
  String? nickname;
  String? name;

TextEditingController _dateController = TextEditingController();

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
                    context, FadePageRoute(page: RegistrationScreen()));
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 330,
                height: 560,
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
                    // Поле NickName
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
                        child: TextField(
                          onChanged: (value) {
                            nickname = value; // Зберігаємо введене значення
                          },
                          decoration: const InputDecoration(
                            labelText: 'NickName',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                          ),
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
                        child: TextField(
                          onChanged: (value) {
                            name = value; // Зберігаємо введене значення
                          },
                          decoration: const InputDecoration(
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
                          controller: _dateController,
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
                              birthday = await showDatePicker(
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
                             if (birthday != null) {
                              _dateController.text = "${birthday!.toLocal()}".split(' ')[0];
                          };
                          }
                        ),
                      ),
                    ),
                    // Вибір Гендеру
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Container(
                        width: 330, 
                        padding: const EdgeInsets.all(12),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 135, 100, 71),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Male',
                                  groupValue: selectedGender,
                                  activeColor: const Color.fromARGB(255, 135, 100, 71), 
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Male',
                                  style: TextStyle(
                                    color: selectedGender == 'Male' ? const Color.fromARGB(255, 135, 100, 71) : Colors.black, 
                                  ),
                                ),
                                const SizedBox(width: 20), 
                                Radio<String>(
                                  value: 'Female',
                                  groupValue: selectedGender,
                                  activeColor: const Color.fromARGB(255, 135, 100, 71),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                                Text(
                                  'Female',
                                  style: TextStyle(
                                    color: selectedGender == 'Female' ? const Color.fromARGB(255, 135, 100, 71) : Colors.black, 
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                          onPressed: () {
                            validateAndSubmit(context);
                          },
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

  bool isEighteenOrOlder(DateTime birthday) {
    final today = DateTime.now();
    final age = today.year - birthday.year;

    // Перевірка, чи день народження вже був у поточному році
    if (today.month < birthday.month ||
        (today.month == birthday.month && today.day < birthday.day)) {
      return age >= 18 - 1; // Якщо ще не було дня народження в цьому році
    }

    return age >= 18; // Якщо день народження вже був
  }

  void validateAndSubmit(BuildContext context) {
    if (nickname == null || nickname!.isEmpty ||
        name == null || name!.isEmpty ||
        birthday == null ||
        selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
    else {
      if(!isEighteenOrOlder(birthday!)){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your age is under 18'),
            backgroundColor: Colors.red,
          ),
        );
      }
      // Все ок
      else{
        addUser(nickname!, name!, selectedGender!, birthday!);
        Navigator.pushReplacement(
            context,
            PushPageRoute(page: MainMenuView()));
      }
    }
  }
}
