import 'package:cross_ways/auth/sign_in_with_google.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/components/custom_error_alert.dart';
import 'package:cross_ways/views/about_as_view.dart';
import 'package:cross_ways/views/friend_profile_view.dart';
import 'package:cross_ways/views/log_in_view.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:cross_ways/views/user_profile_view.dart';
import 'package:cross_ways/views/user_settings.dart';
import 'package:cross_ways/views/vip_purchase_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_symbols_icons/symbols.dart';

class UserFriendsListScreen extends StatefulWidget {
  @override
  _UserFriendsListScreenState createState() => _UserFriendsListScreenState();
}

class _UserFriendsListScreenState extends State<UserFriendsListScreen> {
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
      return const Center(child: Text('User not authenticated'));
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
                  title: const Text('Friends',
                      style: TextStyle(color: Colors.brown, fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context, PushPageRoute(page: UserFriendsListScreen()));
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
                final List<dynamic> friendsList =
                    userData['travelCompanions'] ?? [];

                if (friendsList.isEmpty) {
                  return const Center(
                      child: Text('Ops... You don\'t have friends now.',
                          style: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                              fontSize: 20)));
                }

                return ListView(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 22),
                      child: Text(
                        'Friends:',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: friendsList.length,
                      itemBuilder: (context, index) {
                        final friendId = friendsList[index];

                        return FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(friendId)
                              .get(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> friendSnapshot) {
                            if (friendSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ListTile(title: Text('Loading...'));
                            }

                            if (friendSnapshot.hasError) {
                              return const ListTile(
                                  title: Text('Error loading friend data'));
                            }

                            if (!friendSnapshot.hasData ||
                                !friendSnapshot.data!.exists) {
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(currentUser!.uid)
                                  .update({
                                'travelCompanions':
                                    FieldValue.arrayRemove([friendId]),
                              });
                              return const ListTile(
                                  title: Text('Friend not found'));
                            }

                            final friendData = friendSnapshot.data!.data()
                                as Map<String, dynamic>;
                            final nickname =
                                friendData['nickname'] ?? 'Unknown';
                            final gender = friendData['gender'] ?? 'Unknown';
                            final profileImage =
                                friendData['profileImage'] ?? '';

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
                                  _removeFriend(friendId);
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FriendProfileScreen(uid: friendId),
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

  Future<void> _removeFriend(String friendId) async {
    bool? isConfirmed = await CustomDialogAlert.showConfirmationDialog(
      context,
      'Are you sure?',
      'Do you want to delete this friend from your list?',
    );

    if (isConfirmed == true) {
      final friendListRef =
          FirebaseFirestore.instance.collection('Users').doc(currentUser!.uid);

      try {
        await friendListRef.update({
          'travelCompanions': FieldValue.arrayRemove([friendId]),
        });

        CustomAlert.show(
          context: context,
          title: 'Success',
          content: 'Friend removed successfully!',
          buttonText: 'OK',
        );
      } catch (e) {
        CustomAlert.show(
          context: context,
          title: 'Error',
          content: 'Error removing friend: $e',
          buttonText: 'OK',
        );
      }
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
          context,
          FadePageRoute(page: LogInScreen()),
        );
      }
    }
  }
}
