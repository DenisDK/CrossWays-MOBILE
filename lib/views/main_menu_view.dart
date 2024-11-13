import 'dart:math'; // Import the math package for Random
import 'package:cross_ways/auth/sign_in_with_google.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/subscriptions_search_view.dart';
import 'package:cross_ways/views/log_in_view.dart';
import 'package:cross_ways/views/user_subscriptions_list_view.dart';
import 'package:cross_ways/views/user_profile_view.dart';
import 'package:cross_ways/views/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cross_ways/views/vip_purchase_view.dart';

import 'about_as_view.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  late List<String> imageList;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    imageList = [
      'assets/main_menu_photos/1.jpg',
      'assets/main_menu_photos/2.jpg',
      'assets/main_menu_photos/3.jpg',
      'assets/main_menu_photos/4.jpg',
      'assets/main_menu_photos/5.jpg',
      'assets/main_menu_photos/6.jpg',
      'assets/main_menu_photos/7.jpg',
      'assets/main_menu_photos/8.jpg',
      'assets/main_menu_photos/9.jpg',
      'assets/main_menu_photos/10.jpg',
      'assets/main_menu_photos/11.jpg',
      'assets/main_menu_photos/12.jpg',
      'assets/main_menu_photos/13.jpg',
      'assets/main_menu_photos/14.jpg',
      'assets/main_menu_photos/15.jpg',
      'assets/main_menu_photos/16.jpg',
      'assets/main_menu_photos/17.jpg',
      'assets/main_menu_photos/18.jpg',
      'assets/main_menu_photos/19.jpg',
      'assets/main_menu_photos/20.jpg',
    ];
    imageList.shuffle(Random());
  }

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
                  title: const Text('My profile',
                      style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context, PushPageRoute(page: UserProfileScreen()));
                  },
                ),
                ListTile(
                  title: const Text('Main menu',
                      style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PushPageRoute(page: const MainMenuView()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Subscriptions',
                      style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(context,
                        PushPageRoute(page: UserSubscriptionsListScreen()));
                  },
                ),
                ListTile(
                  title: const Text('VIP',
                      style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context, PushPageRoute(page: (VipPurchaseScreen())));
                  },
                ),
                ListTile(
                  title: const Text('Settings',
                      style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context, PushPageRoute(page: UserSettingsScreen()));
                  },
                ),
                ListTile(
                  title: const Text('About us',
                      style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PushPageRoute(page: const AboutUsScreen()),
                    );
                  },
                ),
                const SizedBox(height: 25),
                ListTile(
                  title: const Text('Sign Out',
                      style: TextStyle(color: Colors.red, fontSize: 18)),
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
                      IconButton(
                        icon: const Icon(
                          Symbols.frame_inspect,
                          fill: 1,
                          color: Color.fromARGB(255, 135, 100, 71),
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context, PushPageRoute(page: UserSearchScreen()));
                        },
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        key: ValueKey<int>(_currentIndex),
                        width: 380,
                        height: 775,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imageList[_currentIndex]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    CarouselSlider.builder(
                      itemCount: imageList.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        return Container();
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 45),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1500),
                        viewportFraction: 1.0,
                        aspectRatio: 0.536,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 200,
                      child: Column(
                        children: [
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
                                shadowColor:
                                    const Color.fromARGB(255, 92, 109, 103),
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
                                shadowColor:
                                    const Color.fromARGB(255, 92, 109, 103),
                              ),
                              child: const Text(
                                'Join the trip',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 92, 109, 103),
                                  fontSize: 15.9,
                                ),
                              ),
                            ),
                          ),
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

  void _handleSignOut(BuildContext context) async {
    bool? result = await CustomDialogAlert.showConfirmationDialog(
      context,
      'Вихід з аккаунту',
      'Ви впевнені, що хочете вийти з аккаунту?',
    );
    if (result != null && result) {
      bool isUserSignOut = await signOut();
      if (isUserSignOut) {
        Navigator.of(context).pushAndRemoveUntil(
          FadePageRoute(page: LogInScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }
}
