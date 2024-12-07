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
import 'package:pay/pay.dart';
import 'package:cross_ways/payment_config.dart';
import 'package:cross_ways/database/update_premium.dart';
import 'about_as_view.dart';
import 'main_menu_view.dart';
import 'package:cross_ways/database/check_user_premium.dart';

class VipPurchaseScreen extends StatefulWidget {
  const VipPurchaseScreen({super.key});
  @override
  State<VipPurchaseScreen> createState() => _VipPurchaseScreenState();
}

class _VipPurchaseScreenState extends State<VipPurchaseScreen> {
  bool isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    doesHasPremium();
  }

  Future<void> doesHasPremium() async {
    bool hasPremium = await checkUserPremiumStatus();
    setState(() {
      isPremiumUser = hasPremium;
    });
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    S.of(context).avaliablePlans,
                    style: TextStyle(
                      color: Color.fromARGB(255, 135, 100, 71),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    S
                        .of(context)
                        .thereAreSeveralPlansForUsingCrosswaysPleaseChooseThe,
                    style: TextStyle(
                      color: Color.fromARGB(255, 135, 100, 71),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  //Перша картка (СТАНДАРТ)
                  Container(
                    height: 550,
                    width: 370,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color.fromARGB(255, 92, 109, 103),
                          width: 5,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).regular,
                          style: TextStyle(
                            color: Color.fromARGB(255, 135, 100, 71),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S
                              .of(context)
                              .useStandardFeaturesToPlanAndSearchForTripsEasily,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 135, 100, 71),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),
                        regularRow(S.of(context).subscribeOnly10People),
                        const SizedBox(
                          height: 15,
                        ),
                        regularRow(S.of(context).haveOnly10ActiveTrips),
                        const SizedBox(
                          height: 15,
                        ),
                        regularRow(S.of(context).addPhotoToYourProfilePicture),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 270,
                          height: 60,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 92, 109, 103),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 3,
                                offset: Offset(0, 2),
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).youHaveThisPlan,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Друга картка (ВІП)
                  Container(
                    height: 630,
                    width: 370,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 92, 109, 103),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color.fromARGB(255, 92, 109, 103),
                          width: 5,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).advanced,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S
                              .of(context)
                              .useAdvancedFunctionallityForABetterUserExperience,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),
                        advancedRow(
                            S.of(context).subscribeUnlimitedNumberOfPeople),
                        const SizedBox(
                          height: 15,
                        ),
                        advancedRow(
                            S.of(context).haveUnlimitedNumberOfActiveTrips),
                        const SizedBox(
                          height: 15,
                        ),
                        advancedRow(S.of(context).addGifToYourProfilePicture),
                        const SizedBox(
                          height: 15,
                        ),
                        advancedRow(S.of(context).makeYourAccountPrivate),
                        const SizedBox(
                          height: 50,
                        ),
                        isPremiumUser
                            ? Container(
                                width: 270,
                                height: 60,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    S.of(context).youHaveThisPlan,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 92, 109, 103),
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            : GooglePayButton(
                                paymentConfiguration:
                                    PaymentConfiguration.fromJsonString(
                                        defaultGooglePay),
                                paymentItems: [
                                  PaymentItem(
                                    label: S.of(context).vipStatus,
                                    amount: '100',
                                    status: PaymentItemStatus.final_price,
                                  ),
                                ],
                                type: GooglePayButtonType.pay,
                                margin: const EdgeInsets.only(top: 10.0),
                                onPaymentResult: (result) {
                                  updateUserPremiumStatus();
                                  setState(() {
                                    isPremiumUser = true;
                                  });
                                },
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                width: 250,
                                theme: GooglePayButtonTheme.light,
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  // Для зменшення коду (Стандартна карточка)
  regularRow(String textToShow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 45,
        ),
        const Icon(
          Icons.check,
          size: 30,
          color: Color.fromARGB(255, 135, 100, 71),
        ),
        const SizedBox(width: 20),
        Container(
          width: 230,
          child: Text(
            textToShow,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Color.fromARGB(255, 135, 100, 71),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  // Для зменшення коду (Покращена карточка)
  advancedRow(String textToShow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 45,
        ),
        const Icon(
          Icons.star,
          size: 30,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        Container(
          width: 220,
          child: Text(
            textToShow,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
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
