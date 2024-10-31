import 'package:cross_ways/auth/sign_in_with_google.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
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
                  onTap: () {},
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
                const SizedBox( height: 25,),
                ListTile(
                  title: const Text('Sign Out', style: TextStyle(color: Colors.red, fontSize: 18)),
                  onTap: () {_handleSignOut(context);},
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
                      const Icon(
                        Symbols.account_circle_filled_rounded,
                        fill: 1,
                        color: Color.fromARGB(255, 135, 100, 71),
                        size: 40,
                      ),
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
            const Padding(padding: EdgeInsets.only(top: 10)),
            Center(
              child: Container(
                width: 380,
                height: 775,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/beachPhoto.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 240)),
                          const Text(
                            'Welcome back!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 5,
                                  color: Color.fromARGB(255, 92, 109, 103),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 45)),
                          SizedBox(
                            width: 250,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 9,
                                shadowColor: const Color.fromARGB(255, 92, 109, 103),
                              ),
                              child: const Text(
                                'Create a new trip',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 92, 109, 103),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 250,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 9,
                                shadowColor: const Color.fromARGB(255, 92, 109, 103),
                              ),
                              child: const Text(
                                'Join the trip',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 92, 109, 103),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
            context, FadePageRoute(page:  LogInScreen()));
      }
    }
  }

