import 'package:cross_ways/auth/sign_in_with_google.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/components/custom_error_alert.dart';
import 'package:cross_ways/generated/l10n.dart';
import 'package:cross_ways/views/about_as_view.dart';
import 'package:cross_ways/views/subscriber_profile_view.dart';
import 'package:cross_ways/views/log_in_view.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:cross_ways/views/user_profile_view.dart';
import 'package:cross_ways/views/user_settings.dart';
import 'package:cross_ways/views/vip_purchase_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_symbols_icons/symbols.dart';

class UserSubscriptionsListScreen extends StatefulWidget {
  @override
  _UserSubscriptionsListScreenState createState() =>
      _UserSubscriptionsListScreenState();
}

class _UserSubscriptionsListScreenState
    extends State<UserSubscriptionsListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Center(child: Text(S.of(context).userNotAuthenticated));
    }

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
                  title: Text(S.of(context).myProfile,
                      style:
                          const TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context, PushPageRoute(page: UserProfileScreen()));
                  },
                ),
                ListTile(
                  title: Text(S.of(context).mainMenu,
                      style:
                          const TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PushPageRoute(page: const MainMenuView()),
                    );
                  },
                ),
                ListTile(
                  title: Text(S.of(context).subscriptions,
                      style:
                          const TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(context,
                        PushPageRoute(page: UserSubscriptionsListScreen()));
                  },
                ),
                ListTile(
                  title: Text(S.of(context).vip,
                      style:
                          const TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(context,
                        PushPageRoute(page: (const VipPurchaseScreen())));
                  },
                ),
                ListTile(
                  title: Text(S.of(context).settings,
                      style:
                          const TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context, PushPageRoute(page: UserSettingsScreen()));
                  },
                ),
                ListTile(
                  title: Text(S.of(context).aboutUs,
                      style:
                          const TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PushPageRoute(page: const AboutUsScreen()),
                    );
                  },
                ),
                const SizedBox(height: 25),
                ListTile(
                  title: Text(S.of(context).signOut,
                      style: const TextStyle(color: Colors.red, fontSize: 18)),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
            ),
            Expanded(
                child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('User not found.'));
                }

                final userData = snapshot.data!.data() as Map<String, dynamic>;
                final List<dynamic> subscriptionsList =
                    userData['travelCompanions'] ?? [];

                if (subscriptionsList.isEmpty) {
                  return Center(
                      child: Text(S.of(context).opsYouDontHaveSubscriptionsNow,
                          style: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                              fontSize: 20)));
                }

                return ListView(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 22),
                      child: Text(
                        S.of(context).subscriptions,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: subscriptionsList.length,
                      itemBuilder: (context, index) {
                        final subscriberId = subscriptionsList[index];

                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(subscriberId)
                              .get(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot>
                                  subscriptionsSnapshot) {
                            if (subscriptionsSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                  title: Text(S.of(context).loading));
                            }

                            if (subscriptionsSnapshot.hasError) {
                              return ListTile(
                                  title: Text(S
                                      .of(context)
                                      .errorLoadingSubscriberData));
                            }

                            if (!subscriptionsSnapshot.hasData ||
                                !subscriptionsSnapshot.data!.exists) {
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(currentUser!.uid)
                                  .update({
                                'travelCompanions':
                                    FieldValue.arrayRemove([subscriberId]),
                              });
                              return ListTile(
                                  title: Text(
                                      S.of(context).subscriptionsNotFound));
                            }

                            final subscribeData = subscriptionsSnapshot.data!
                                .data() as Map<String, dynamic>;
                            final nickname = subscribeData['nickname'] ??
                                S.of(context).unknown;
                            final gender = subscribeData['gender'] ??
                                S.of(context).unknown;
                            final profileImage =
                                subscribeData['profileImage'] ?? '';

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: profileImage.isNotEmpty
                                    ? NetworkImage(profileImage)
                                    : const AssetImage('assets/placeholder.png')
                                        as ImageProvider,
                              ),
                              title: Text(nickname),
                              subtitle: Text(gender),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.brown,
                                ),
                                onPressed: () {
                                  _removeSubscriber(subscriberId);
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubscriberProfileScreen(
                                            uid: subscriberId),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _removeSubscriber(String subscriptionsId) async {
    bool? isConfirmed = await CustomDialogAlert.showConfirmationDialog(
      context,
      S.of(context).areYouSure,
      S.of(context).doYouWantToDeleteThisSubscriptionsFromYourList,
    );

    if (isConfirmed == true) {
      final subscriptionsListRef =
          FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid);

      try {
        await subscriptionsListRef.update({
          'travelCompanions': FieldValue.arrayRemove([subscriptionsId]),
        });

        CustomAlert.show(
          context: context,
          title: S.of(context).success,
          content: S.of(context).subscriptionsRemovedSuccessfully,
          buttonText: 'OK',
        );
      } catch (e) {
        CustomAlert.show(
          context: context,
          title: S.of(context).error,
          content: S.of(context).errorRemovingSubscriptionsE,
          buttonText: 'OK',
        );
      }
    }
  }

  void _handleSignOut(BuildContext context) async {
    bool? result = await CustomDialogAlert.showConfirmationDialog(
      context,
      S.of(context).logOutOfAccount,
      S.of(context).areYouSureYouWantToLogOut,
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
