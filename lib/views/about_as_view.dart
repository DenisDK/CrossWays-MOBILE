import 'package:cross_ways/auth/sign_in_with_google.dart';
import 'package:cross_ways/components/alert_dialog_custom.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/generated/l10n.dart';
import 'package:cross_ways/views/log_in_view.dart';
import 'package:cross_ways/views/user_subscriptions_list_view.dart';
import 'package:cross_ways/views/user_profile_view.dart';
import 'package:cross_ways/views/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:cross_ways/views/vip_purchase_view.dart';

import 'main_menu_view.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  Row(
                    children: [
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
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Перша картка (find your travel)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 380,
                            height: 775,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/main_menu_photos/1.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Positioned(
                            left: 25,
                            right: 0,
                            top: 150,
                            child: Column(
                              children: [
                                Text(
                                  S
                                      .of(context)
                                      .findYourTravelSoulmateFastEasily,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 5,
                                        color:
                                            Color.fromARGB(255, 92, 109, 103),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Text(
                                  S
                                      .of(context)
                                      .crossWaysAndExploreTheWorldTogether,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2, 2),
                                        blurRadius: 5,
                                        color:
                                            Color.fromARGB(255, 92, 109, 103),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Друга картка (About us)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 25),
                      child: Stack(
                        children: [
                          Container(
                            width: 380,
                            height: 775,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/main_menu_photos/4.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          // Затемнення
                          Container(
                            width: 380,
                            height: 775,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          // Друга картка (About us)
                          Positioned(
                            left: 25,
                            top: 150,
                            child: SizedBox(
                              width: 330,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).aboutUs,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                      height:
                                          20), // Заміна Padding для відступу між текстами
                                  Text(
                                    S
                                            .of(context)
                                            .crosswaysIsAnInternationalPlatformCreatedToHelpPeopleStruggling +
                                        S
                                            .of(context)
                                            .withFindingCompanyForTheirTripsOrFeelingDesireTo +
                                        S
                                            .of(context)
                                            .developedByTheGroupOfParticularlyStubbornStudentsCrosswaysHas +
                                        S
                                            .of(context)
                                            .youALotOfUsefulToolsForSatisfyingWorkAnd,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 550,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(70, 135, 100, 71),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).topOpportunitiesForYou,
                            style: TextStyle(
                              color: Color.fromARGB(255, 135, 100, 71),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 30,
                            childAspectRatio: 0.8,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildOpportunityItem(
                                icon: Icons.favorite,
                                title: S.of(context).findingFriends,
                                description:
                                    S.of(context).meetPeopleToTravelTogether,
                              ),
                              _buildOpportunityItem(
                                icon: Icons.compare_arrows,
                                title: S.of(context).travelMatching,
                                description: S
                                    .of(context)
                                    .filterTravelsAndPeopleByOurSpecialTool,
                              ),
                              _buildOpportunityItem(
                                icon: Icons.explore,
                                title: S.of(context).tripPlanning,
                                description: S
                                    .of(context)
                                    .weWillHelpYouWithTheBoringStuff,
                              ),
                              _buildOpportunityItem(
                                icon: Icons.help,
                                title: S.of(context).freeTravelAdvice,
                                description:
                                    S.of(context).weWillAlwaysHelpYouOut,
                              ),
                            ],
                          ),
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

  Widget _buildOpportunityItem(
      {required IconData icon,
      required String title,
      required String description}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color.fromARGB(255, 92, 109, 103),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 135, 100, 71),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 135, 100, 71),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
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
