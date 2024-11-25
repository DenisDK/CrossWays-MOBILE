import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/database/check_user_premium.dart';
import 'package:cross_ways/database/check_user_private.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cross_ways/views/trip_details_view.dart';
import '../components/animation_route.dart';

class SubscriberProfileScreen extends StatefulWidget {
  final String uid;

  SubscriberProfileScreen({required this.uid});

  @override
  _SubscriberProfileScreenState createState() =>
      _SubscriberProfileScreenState();
}

class _SubscriberProfileScreenState extends State<SubscriberProfileScreen> {
  late Future<Map<String, dynamic>?> _userDataFuture;
  late Future<List<Map<String, dynamic>>?> _userTripsFuture;
  bool isPremiumUser = false;
  bool isPrivateUser = false;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData(widget.uid);
    _userTripsFuture = _fetchUserTrips(widget.uid);
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

  Future<List<Map<String, dynamic>>?> _fetchUserTrips(String uid) async {
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

            return SingleChildScrollView(
              child: Column(
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 25),
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
                                        color:
                                            Color.fromARGB(255, 135, 100, 71),
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
                                    : Text(
                                        gender,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 135, 100, 71),
                                        ),
                                      ),
                                isPrivateUser
                                    ? SizedBox()
                                    : Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < 4
                                                ? Icons.star
                                                : Icons.star_border,
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
                        if (!isPrivateUser) ...[
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
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
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
                                return const Center(
                                    child: Text(
                                  'No trips found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.brown,
                                  ),
                                ));
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
                                    final tripMembers = trip['memberLimit'] ??
                                        'Unnamed members';
                                    final tripDescription =
                                        trip['description'] ?? '';
                                    final tripImageUrl = trip['imageUrl'];

                                    String formattedStartDate = '';
                                    String formattedEndDate = '';

                                    try {
                                      var fromDate = trip['from'];
                                      var toDate = trip['to'];

                                      if (fromDate is Timestamp) {
                                        DateTime startDate = fromDate.toDate();
                                        formattedStartDate =
                                            "${startDate.day}-${startDate.month}-${startDate.year}";
                                      } else if (fromDate is String) {
                                        formattedStartDate = fromDate;
                                      }

                                      if (toDate is Timestamp) {
                                        DateTime endDate = toDate.toDate();
                                        formattedEndDate =
                                            "${endDate.day}-${endDate.month}-${endDate.year}";
                                      } else if (toDate is String) {
                                        formattedEndDate = toDate;
                                      }
                                    } catch (e) {
                                      formattedStartDate = 'Date not available';
                                      formattedEndDate = 'Date not available';
                                    }

                                    return Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PushPageRoute(
                                              page: TripDetailsScreen(
                                                tripName: tripName,
                                                tripDescription:
                                                    tripDescription,
                                                tripImageUrl: tripImageUrl,
                                                formattedStartDate:
                                                    formattedStartDate,
                                                formattedEndDate:
                                                    formattedEndDate,
                                                country: tripCountry,
                                                creator: tripCreator,
                                                memberLimit: tripMembers,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            tripImageUrl != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "$formattedStartDate / $formattedEndDate",
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
                        ] else ...[
                          const Padding(
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
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
