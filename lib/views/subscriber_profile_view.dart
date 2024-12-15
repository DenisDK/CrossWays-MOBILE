import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/database/check_user_rating.dart';
import 'package:cross_ways/database/check_user_premium.dart';
import 'package:cross_ways/database/check_user_private.dart';
import 'package:cross_ways/database/check_your_rating_to_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cross_ways/views/trip_details_view.dart';
import '../components/animation_route.dart';
import '../database/create_comment.dart';
import '../database/delete_comment.dart';
import '../database/pick_user_rating.dart';
import '../generated/l10n.dart';

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
  double rating = 0.00;
  int selectedStars = 0;
  bool isEvaluated = false;
  final TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData(widget.uid);
    _userTripsFuture = _fetchUserTrips(widget.uid);
    doesHasPremium(widget.uid);
    doesAccountPrivate(widget.uid);
    checkRating(widget.uid);
    checkForSeletedStars(widget.uid);
    _fetchComments();
  }

  // Метод для отримання коментарів
  Future<void> _fetchComments() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Users') // Колекція користувачів
          .doc(widget.uid) // userId передається
          .collection('FeedbackComment') // Колекція коментарів
          .get();

      // Отримуємо список коментарів
      List<Map<String, dynamic>> fetchedComments = snapshot.docs.map((doc) {
        return {
          'documentId': doc.id,
          'authorId': doc['authorId'] ?? '',
          'authorName':
              doc['authorName'] ?? 'Unknown', // Перевірка на відсутність даних
          'text': doc['text'] ?? '', // Перевірка на відсутність тексту
        };
      }).toList();

      // Оновлюємо стан
      setState(() {
        comments = fetchedComments;
        print(fetchedComments);
      });
    } catch (e) {
      print("Error fetching comments: $e");
    }
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

  Future<void> checkForSeletedStars(String userId) async {
    int howManyStars = await getUserFeedbackForTarget(userId);
    if (howManyStars > 0) {
      setState(() {
        selectedStars = howManyStars;
        isEvaluated = true;
      });
    }
  }

  Future<void> checkRating(String userId) async {
    double whatRating = await calculateAverageRating(userId);
    setState(() {
      rating = whatRating;
    });
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
            final name = userData['name'] ?? S.of(context).name;
            final gender = userData['gender'] ?? S.of(context).gender;
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Зірочки
                                          ...List.generate(5, (index) {
                                            return GestureDetector(
                                              onTap: () async {
                                                if (!isEvaluated) {
                                                  setState(() {
                                                    selectedStars = index +
                                                        1; // Оновлення кількості зірок
                                                    isEvaluated = true;
                                                    checkRating(widget
                                                        .uid); // Позначка, що оцінка зроблена
                                                  });

                                                  // Виклик функції для додавання відгуку
                                                  try {
                                                    String targetUserId = widget
                                                        .uid; // Заміни на реальний ID користувача
                                                    await addFeedback(
                                                        targetUserId,
                                                        selectedStars);
                                                    print(
                                                        'Відгук успішно додано');
                                                  } catch (e) {
                                                    print(
                                                        'Помилка при додаванні відгуку: $e');
                                                  }
                                                } else {
                                                  print(
                                                      'Ви вже оцінювали цю людину');
                                                }
                                              },
                                              child: Icon(
                                                index < selectedStars
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.lightBlueAccent,
                                                size: 23,
                                              ),
                                            );
                                          }),
                                          const SizedBox(
                                              width:
                                                  10), // Проміжок між зірками і текстом
                                          // Текст рейтингу
                                          Text(
                                            '${rating}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 135, 100, 71),
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (!isPrivateUser) ...[
                          Text(
                            S.of(context).aboutMe,
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
                          Text(
                            S.of(context).myTrips,
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
                                return Center(
                                    child:
                                        Text(S.of(context).errorFetchingTrips));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text(
                                  S.of(context).noTripsFound,
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
                                    final tripName = trip['title'] ??
                                        S.of(context).unnamedTrip;
                                    final tripCountry = trip['country'] ??
                                        S.of(context).unnamedCountry;
                                    final tripCreator = trip['creatorId'] ??
                                        S.of(context).unnamedCreator;
                                    final tripMembers = trip['memberLimit'] ??
                                        S.of(context).unnamedMembers;
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
                                      formattedStartDate =
                                          S.of(context).dateNotAvailable;
                                      formattedEndDate =
                                          S.of(context).dateNotAvailable;
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
                          // Перевести все знизу, що стосується коментарів
                          Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Text(
                              S.of(context).comments,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 135, 100, 71),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Поле для написання коментаря
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  children: [
                                    // Текстове поле
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            commentController, // Контролер для введення тексту
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          hintText: S.of(context).writeAComment,
                                          hintStyle:
                                              TextStyle(color: Colors.brown),
                                          filled: true,
                                          fillColor: Colors.brown[100],
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.brown.withOpacity(0.5),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.brown.withOpacity(1),
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Кнопка для надсилання коментаря
                                    IconButton(
                                      onPressed: () {
                                        // Логіка додавання коментаря
                                        if (commentController.text.isNotEmpty) {
                                          addFeedbackComment(widget.uid,
                                              commentController.text);
                                          _fetchComments();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Список коментарів
                              Container(
                                height: comments.isEmpty
                                    ? 30
                                    : comments.length *
                                        75, // Висота, якщо немає коментарів
                                child: comments.isEmpty
                                    ? Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            S.of(context).noCommentsYet,
                                            style: TextStyle(
                                                color: Colors.brown,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: comments.length,
                                        itemBuilder: (context, index) {
                                          var comment = comments[index];
                                          User? currentUser =
                                              FirebaseAuth.instance.currentUser;
                                          bool isCurrentUser = comment[
                                                  'authorId'] ==
                                              currentUser
                                                  ?.uid; // Перевірка на поточного користувача

                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.brown[100],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Ліва частина: нікнейм та текст коментаря
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          comment['authorName'] ??
                                                              S
                                                                  .of(context)
                                                                  .unknown, // Виведення нікнейму
                                                          style: TextStyle(
                                                            color: Colors.brown,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          comment['text'] ?? '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.brown,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Якщо це коментар поточного користувача, додаємо кнопку для видалення
                                                  if (isCurrentUser)
                                                    IconButton(
                                                      icon: Icon(Icons.delete,
                                                          color: Colors.red),
                                                      onPressed: () async {
                                                        // Викликаємо метод видалення
                                                        await deleteComment(
                                                            widget.uid,
                                                            comment[
                                                                'documentId']);
                                                        _fetchComments();
                                                      },
                                                    ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              )
                            ],
                          )
                        ] else ...[
                          Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text(
                                S.of(context).thisProfileIsPrivate,
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
