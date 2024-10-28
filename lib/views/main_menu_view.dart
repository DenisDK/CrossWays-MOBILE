import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/user_reg_view.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row( 
                    children: [
                      Text(
                        'CrossWays',
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5), 
                      Icon(
                        Symbols.flightsmode, 
                        color: Color.fromARGB(255, 135, 100, 71),
                        size: 30,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Symbols.account_circle_filled_rounded,
                        fill: 1,
                        color: Color.fromARGB(255, 135, 100, 71),
                        size: 34,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Color.fromARGB(255, 135, 100, 71),
                        size: 34,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Center(
              child: Container(
                width: 380,
                height: 770,
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
                              fontSize: 43,
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
                          const Padding(padding: EdgeInsets.only(top: 25)),
                          SizedBox(
                            width: 250,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                               Navigator.pushReplacement(
                              context,
                              PushPageRoute(page: UserRegScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 9,
                                shadowColor: const Color.fromARGB(255, 92, 109, 103),
                              ),
                              child: const Text(
                                'Create a new trip',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 92, 109, 103),
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
