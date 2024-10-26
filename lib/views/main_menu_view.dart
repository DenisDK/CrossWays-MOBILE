import 'package:flutter/material.dart';

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
                  Text(
                    'CrossWays 🛩️',
                    style: TextStyle(
                      color: Color.fromARGB(255, 135, 100, 71),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 135, 100, 71),
                        size: 28,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Color.fromARGB(255, 135, 100, 71),
                        size: 28,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
              child: Container(
                width: 370,
                height: 750,
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
                          Padding(padding: EdgeInsets.only(top: 240)),
                          const Text(
                            'Welcome back!',
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 5,
                                color: Color.fromARGB(255, 92, 109, 103)
                              )
                            ]
                          ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 25)),
                          SizedBox(
                            width: 230,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                // Дія при натисканні кнопки
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 9,
                                shadowColor: Color.fromARGB(255, 92, 109, 103),
                              ),
                              child: Text(
                                'Create a new trip',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 92, 109, 103),
                                ),
                              ),
                            ),
                          )

                        ],
                      )
                    )
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}