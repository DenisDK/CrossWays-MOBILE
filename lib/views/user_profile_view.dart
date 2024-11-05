import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../auth/sign_in_with_google.dart';
import '../components/alert_dialog_custom.dart';
import '../components/animation_route.dart';
import 'log_in_view.dart';


class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: ClipRect(
        child: SizedBox(
          width: 200,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                IconButton(
                  alignment: Alignment.topRight,
                  icon: const Icon(Icons.close, color: Colors.brown, size: 40),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ListTile(
                  title: const Text('My profile', style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PushPageRoute(page: UserProfileScreen()));
                  },
                ),
                ListTile(
                  title: const Text('My trips', style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Something', style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Something', style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {},
                ),
                const SizedBox(height: 25),
                ListTile(
                  title: const Text('Sign Out', style: TextStyle(color: Colors.red, fontSize: 18)),
                  onTap: () {
                    _handleSignOut(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'CrossWays',
                          style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        SizedBox(width: 5),
                        Icon(
                          Symbols.flightsmode,
                          color: Color.fromARGB(255, 135, 100, 71),
                          size: 35,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(
                              Symbols.format_list_bulleted,
                              color: Color.fromARGB(255, 135, 100, 71),
                              size: 40,
                            ),
                            onPressed: () => Scaffold.of(context).openEndDrawer(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // АВАТАР КОРИСТУВАЧА
                        CircleAvatar(
                          radius: 40,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ім'я прям ім'я
                            const Text(
                              'Name',
                              style: TextStyle(
                                color: Color.fromARGB(255, 135, 100, 71),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Нікнейм для пошуку (той що не повторюється)
                            const Text(
                              '@nameForSearch',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 135, 100, 71),
                              ),
                            ),
                            // Гендер?
                            const Text(
                              'gender (attack helicopter:) )',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 135, 100, 71),
                              ),
                            ),
                            // Рейтинг той що зірочками (покашо тільки виводить зірочки там де index < 4)
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < 4 ? Icons.star : Icons.star_border,
                                  color: Colors.lightBlueAccent,
                                  size: 18,
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Заголовок про себе
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Color.fromARGB(255, 135, 100, 71),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Про себе
                    Container(
                      width: 500,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(90, 135, 100, 71),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Text(
                            'Wats up my homies, i really want to trawel with uall',
                            style: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ),
                    const SizedBox(height: 20),
                    // Заголовок подорожі
                    const Text(
                      'Trips (?)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 135, 100, 71),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      );
  }



  void _handleSignOut(BuildContext context) async {
    bool? result = await CustomDialogAlert.showConfirmationDialog(
      context,
      'Вихід з аккаунту',
      'Ви впевнені, що хочете вийти з аккаунту?',
    );
    if (result != null && result) {
      bool isUserSignOut = await signOut();
      if (isUserSignOut) {
        Navigator.pushReplacement(
          context,
          FadePageRoute(page: LogInScreen()),
        );
      }
    }
  }
}