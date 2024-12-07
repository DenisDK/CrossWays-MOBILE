import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/database/update_user_data.dart';
import 'package:cross_ways/generated/l10n.dart';
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
import '../database/check_user_premium.dart';
import '../database/check_user_private.dart';
import '../database/update_user_private.dart';
import 'about_as_view.dart';
import 'package:cross_ways/database/delete_user.dart';

class UserSettingsScreen extends StatefulWidget {
  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool isPremiumUser = false;
  bool isPrivateUser = false;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    doesHasPremium(user!.uid);
    doesAccountPrivate(user!.uid);
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
    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController aboutController = TextEditingController();

    bool isNullOrWhiteSpace(String? value) {
      return value == null || value.trim().isEmpty;
    }

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
                    Text(
                      S.of(context).userProfile,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).manageDataAboutYourself,
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
                                  child: Text(
                                    S.of(context).uploadNew,
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
                    isPremiumUser
                        ? Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Colors.brown[100],
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).makeProfilePrivate,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown,
                                      ),
                                    ),
                                    Switch(
                                      value: isPrivateUser,
                                      inactiveTrackColor: Colors.brown[100],
                                      inactiveThumbColor: Colors.brown,
                                      activeColor: const Color(0xFF5C6D67),
                                      onChanged: (value) {
                                        setState(() {
                                          isPrivateUser = value;
                                          updateUserPrivateStatus();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
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
                            Text(
                              S.of(context).generalInformation,
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
                                  labelText: S.of(context).name,
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
                                  labelText: S.of(context).username,
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

                                    if (!isNullOrWhiteSpace(name) ||
                                        !isNullOrWhiteSpace(username)) {
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
                                        SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .pleaseFillInAtLeastOneFieldToUpdate)),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5C6D67),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    S.of(context).update,
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
                            Text(
                              S.of(context).additionalData,
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
                                  labelText: S.of(context).aboutYourself,
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
                                        SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .pleaseFillInAtLeastOneFieldToUpdate)),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5C6D67),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    S.of(context).update,
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
                                      S.of(context).confirmationOfDeletion,
                                      S
                                          .of(context)
                                          .areYouSureYouWantToDeleteYourAccountThis);
                              if (confirm == true) {
                                deleteUserFromDatabase();
                                Navigator.pushReplacement(context,
                                    FadePageRoute(page: LogInScreen()));
                              }
                            },
                            child: Text(
                              S.of(context).deleteAccount,
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
