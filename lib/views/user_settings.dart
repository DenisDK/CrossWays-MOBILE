import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/database/update_user_data.dart';
import 'package:cross_ways/views/user_subscriptions_list_view.dart';
import 'package:cross_ways/views/vip_purchase_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cross_ways/auth/sign_in_with_google.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/log_in_view.dart';
import 'package:cross_ways/views/main_menu_view.dart';
import 'package:cross_ways/views/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'about_as_view.dart';
import 'package:cross_ways/database/delete_user.dart';

class UserSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController aboutController = TextEditingController();

    Future<String?> getUserAvatarUrl() async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        return doc['profileImage'] as String?;
      }
      return null;
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Builder(
                builder: (context) => Row(
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
                    IconButton(
                      icon: const Icon(
                        Symbols.format_list_bulleted,
                        color: Color.fromARGB(255, 135, 100, 71),
                        size: 35,
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Profile',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Manage data about yourself',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.brown[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder<String?>(
                                  future: getUserAvatarUrl(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Icon(Icons.error, size: 77);
                                    } else if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      return CircleAvatar(
                                        radius: 77,
                                        backgroundImage:
                                            NetworkImage(snapshot.data!),
                                      );
                                    } else {
                                      return const CircleAvatar(
                                        radius: 77,
                                        backgroundImage: AssetImage(
                                            'assets/standardImage.jpg'),
                                      );
                                    }
                                  },
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await uploadAvatar(context);
                                    Navigator.push(
                                      context,
                                      FadePageRoute(page: UserSettingsScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Upload new',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.brown,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.brown[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'General information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 135, 100, 71),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 135, 100, 71),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String? name =
                                        nameController.text.isNotEmpty
                                            ? nameController.text
                                            : null;
                                    String? username =
                                        usernameController.text.isNotEmpty
                                            ? usernameController.text
                                            : null;

                                    if (name != null || username != null) {
                                      await updateProfileNameUsername(
                                          context, name, username);
                                      Navigator.push(
                                        context,
                                        FadePageRoute(
                                            page: UserSettingsScreen()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Заповніть хоча б одне поле для оновлення')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5C6D67),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(color: Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.brown[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Additional data',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextField(
                                controller: aboutController,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize:
                                      16, // Встановіть бажаний розмір шрифту
                                ),
                                decoration: InputDecoration(
                                  labelText: 'About yourself',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 135, 100, 71),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String? about =
                                        aboutController.text.isNotEmpty
                                            ? aboutController.text
                                            : null;
                                    if (about != null) {
                                      await updateProfileAbout(context, about);
                                      Navigator.push(
                                        context,
                                        FadePageRoute(
                                            page: UserSettingsScreen()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Заповніть хоча б одне поле для оновлення')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5C6D67),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(color: Color(0xFFFFFFFF)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[100],
                                minimumSize: Size(double.infinity, 50)),
                            onPressed: () async {
                              final bool? confirm = await CustomDialogAlert
                                  .showConfirmationDialog(
                                      context,
                                      'Confirmation of deletion',
                                      'Are you sure you want to delete your account? This action cannot be undone.');
                              if (confirm == true) {
                                deleteUserFromDatabase();
                                Navigator.pushReplacement(context,
                                    FadePageRoute(page: LogInScreen()));
                              }
                            },
                            child: Text(
                              'Delete account',
                              style: TextStyle(
                                color: Colors.red[400],
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            )),
                      ),
                    )
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
        context,
        FadePageRoute(page: LogInScreen()),
      );
    }
  }
}
