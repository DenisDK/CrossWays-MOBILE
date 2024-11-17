import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/database/check_user_premium.dart';
import 'package:cross_ways/database/check_user_private.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SubscriberProfileScreen extends StatefulWidget {
  final String uid;

  SubscriberProfileScreen({required this.uid});

  @override
  _SubscriberProfileScreenState createState() =>
      _SubscriberProfileScreenState();
}

class _SubscriberProfileScreenState extends State<SubscriberProfileScreen> {
  late Future<Map<String, dynamic>?> _userDataFuture;
  bool isPremiumUser = false;
  bool isPrivateUser = false;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData(widget.uid);
    doesHasPremium(widget.uid);
    doesAccountPrivate(widget.uid);
  }

  Future<Map<String, dynamic>?> _fetchUserData(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    if (userDoc.exists) {
      return userDoc.data();
    }
    return null;
  }

  Future<void> doesHasPremium(String userId) async {
    bool hasPremium = await checkUserPremiumStatusById(userId);
    setState(() {
      isPremiumUser = hasPremium;
    });
  }

  Future<void> doesAccountPrivate(String userId) async {
    bool isPrivate = await checkUserPrivateStatusById(userId);
    setState(() {
      isPrivateUser = isPrivate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final userData = snapshot.data!;
            final nickname = userData['nickname'] ?? '@nameForSearch';
            final name = userData['name'] ?? 'Name';
            final gender = userData['gender'] ?? 'Gender';
            final profileImageUrl = userData['profileImage'];
            final aboutMe = userData['aboutMe'] ?? '';
            final travels = userData['travels'] as List<dynamic>? ?? [];

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: profileImageUrl != null
                                ? NetworkImage(profileImageUrl)
                                : null,
                            child: profileImageUrl == null
                                ? const Icon(Icons.person,
                                    size: 40, color: Colors.brown)
                                : null,
                          ),
                          const SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    name + " ",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 135, 100, 71),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  isPremiumUser
                                      ? const Icon(
                                          Symbols.diamond_rounded,
                                          color: Colors.brown,
                                          size: 30,
                                        )
                                      : const SizedBox()
                                ],
                              ),
                              Text(
                                "@" + nickname,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 100, 71),
                                ),
                              ),
                              isPrivateUser
                                ? SizedBox()
                                :Text(
                                gender,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 100, 71),
                                ),
                              ),
                              isPrivateUser
                                  ? SizedBox()
                                  :Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < 4 ? Icons.star : Icons.star_border,
                                    color: Colors.lightBlueAccent,
                                    size: 23,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      isPrivateUser
                          ? const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Center(
                                child: Text(
                                  'This profile is Private',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 135, 100, 71),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          :const Text(
                        'About me',
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      isPrivateUser
                          ? SizedBox()
                          :Container(
                        width: 500,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(90, 135, 100, 71),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              aboutMe.isNotEmpty
                                  ? aboutMe
                                  : "You haven't added any information about yourself.",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 135, 100, 71),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      isPrivateUser
                          ? SizedBox()
                          :Row(
                        children: [
                          const Text(
                            'Travels',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 135, 100, 71),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '(${travels.length})',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 135, 100, 71),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      isPrivateUser
                          ? SizedBox()
                          :travels.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: travels.map((travel) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    '- $travel',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 135, 100, 71),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : const Text(
                              'No travels found.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 135, 100, 71),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}