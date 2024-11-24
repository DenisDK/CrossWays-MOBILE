import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:cross_ways/views/trip_details_view.dart';
import 'package:cross_ways/views/user_subscriptions_list_view.dart';
import 'package:cross_ways/views/user_settings.dart';
import 'package:cross_ways/views/vip_purchase_view.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../auth/sign_in_with_google.dart';
import '../components/alert_dialog_custom.dart';
import '../components/animation_route.dart';
import '../database/check_user_premium.dart';
import 'about_as_view.dart';
import 'log_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<Map<String, dynamic>?> _userDataFuture;
  late Future<List<Map<String, dynamic>>?> _userTripsFuture;
  bool isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
    _userTripsFuture = _fetchUserTrips();
    doesHasPremium();
  }

  Future<Map<String, dynamic>?> _fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;
      final userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data();
      }
    }
    return null;
  }

  Future<void> doesHasPremium() async {
    bool hasPremium = await checkUserPremiumStatus();
    setState(() {
      isPremiumUser = hasPremium;
    });
  }

  Future<List<Map<String, dynamic>>?> _fetchUserTrips() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;
      final userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userDoc.exists) {
        List<dynamic> activeTripsIds = userDoc.data()!['activeTravels'] ?? [];
        List<Map<String, dynamic>> trips = [];

        for (var tripId in activeTripsIds) {
          DocumentSnapshot tripDoc = await FirebaseFirestore.instance
              .collection('Trips')
              .doc(tripId)
              .get();
          if (tripDoc.exists) {
            trips.add(tripDoc.data() as Map<String, dynamic>);
          }
        }
        return trips;
      }
    }
    return null;
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
                    Navigator.push(context,
                        PushPageRoute(page: (const VipPurchaseScreen())));
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

            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                            size: 30,
                          ),
                        ],
                      ),
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(
                            Symbols.format_list_bulleted,
                            color: Color.fromARGB(255, 135, 100, 71),
                            size: 35,
                          ),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        ),
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
                              Text(
                                gender,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 100, 71),
                                ),
                              ),
                              Row(
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
                      const SizedBox(height: 20),
                      const Text(
                        'About me',
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 500,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(90, 135, 100, 71),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            aboutMe,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 135, 100, 71),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'My Trips',
                        style: TextStyle(
                          color: Color.fromARGB(255, 135, 100, 71),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      FutureBuilder<List<Map<String, dynamic>>?>(
                        // Відображення подорожей
                        future: _userTripsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Error fetching trips'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(child: Text('No trips found'));
                          } else {
                            final trips = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: trips.length,
                              itemBuilder: (context, index) {
                                final trip = trips[index];
                                final tripName =
                                    trip['title'] ?? 'Unnamed trip';
                                final tripCountry =
                                    trip['country'] ?? 'Unnamed country';
                                final tripCreator =
                                    trip['creatorId'] ?? 'Unnamed creator';
                                final tripMembers =
                                    trip['memberLimit'] ?? 'Unnamed members';
                                final tripDescription =
                                    trip['description'] ?? '';
                                final tripImageUrl = trip['imageUrl'];
                                Timestamp timestampFrom =
                                    trip['from']; // Timestamp для "From"
                                Timestamp timestampTo =
                                    trip['to']; // Timestamp для "To"
                                DateTime startDate = timestampFrom.toDate();
                                DateTime endDate = timestampTo.toDate();
                                String formattedStartDate =
                                    "${startDate.day}-${startDate.month}-${startDate.year}";
                                String formattedEndDate =
                                    "${endDate.day}-${endDate.month}-${endDate.year}";
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PushPageRoute(
                                              page: UserProfileScreen()));
                                      Navigator.pushReplacement(
                                          context,
                                          PushPageRoute(
                                            page: TripDetailsScreen(
                                              tripName: tripName,
                                              tripDescription: tripDescription,
                                              tripImageUrl: tripImageUrl,
                                              formattedStartDate:
                                                  formattedStartDate,
                                              formattedEndDate:
                                                  formattedEndDate,
                                              country: tripCountry,
                                              creator: tripCreator,
                                              memberLimit: tripMembers,
                                            ),
                                          ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        tripImageUrl != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  tripImageUrl,
                                                  width: double.infinity,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const Icon(Icons.image,
                                                size: 100),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                tripName,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "$formattedStartDate - $formattedEndDate",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.brown,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ));
          },
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
