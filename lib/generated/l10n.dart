// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get continueWithFacebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'continueWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `NickName`
  String get nickname {
    return Intl.message(
      'NickName',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Pick a date`
  String get pickADate {
    return Intl.message(
      'Pick a date',
      name: 'pickADate',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields`
  String get pleaseFillInAllFields {
    return Intl.message(
      'Please fill in all fields',
      name: 'pleaseFillInAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Your age is under 18`
  String get yourAgeIsUnder18 {
    return Intl.message(
      'Your age is under 18',
      name: 'yourAgeIsUnder18',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButton {
    return Intl.message(
      'Continue',
      name: 'continueButton',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get myProfile {
    return Intl.message(
      'My profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Main menu`
  String get mainMenu {
    return Intl.message(
      'Main menu',
      name: 'mainMenu',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get subscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'subscriptions',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get vip {
    return Intl.message(
      'VIP',
      name: 'vip',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Create a new trip`
  String get createANewTrip {
    return Intl.message(
      'Create a new trip',
      name: 'createANewTrip',
      desc: '',
      args: [],
    );
  }

  /// `Join the trip`
  String get joinTheTrip {
    return Intl.message(
      'Join the trip',
      name: 'joinTheTrip',
      desc: '',
      args: [],
    );
  }

  /// `Log out of account`
  String get logOutOfAccount {
    return Intl.message(
      'Log out of account',
      name: 'logOutOfAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get areYouSureYouWantToLogOut {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'areYouSureYouWantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get aboutMe {
    return Intl.message(
      'About me',
      name: 'aboutMe',
      desc: '',
      args: [],
    );
  }

  /// `My Trips`
  String get myTrips {
    return Intl.message(
      'My Trips',
      name: 'myTrips',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching trips`
  String get errorFetchingTrips {
    return Intl.message(
      'Error fetching trips',
      name: 'errorFetchingTrips',
      desc: '',
      args: [],
    );
  }

  /// `No trips found`
  String get noTripsFound {
    return Intl.message(
      'No trips found',
      name: 'noTripsFound',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed trip`
  String get unnamedTrip {
    return Intl.message(
      'Unnamed trip',
      name: 'unnamedTrip',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed country`
  String get unnamedCountry {
    return Intl.message(
      'Unnamed country',
      name: 'unnamedCountry',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed creator`
  String get unnamedCreator {
    return Intl.message(
      'Unnamed creator',
      name: 'unnamedCreator',
      desc: '',
      args: [],
    );
  }

  /// `Unnamed members`
  String get unnamedMembers {
    return Intl.message(
      'Unnamed members',
      name: 'unnamedMembers',
      desc: '',
      args: [],
    );
  }

  /// `Date not available`
  String get dateNotAvailable {
    return Intl.message(
      'Date not available',
      name: 'dateNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `User not authenticated`
  String get userNotAuthenticated {
    return Intl.message(
      'User not authenticated',
      name: 'userNotAuthenticated',
      desc: '',
      args: [],
    );
  }

  /// `Ops... You don\'t have subscriptions now.`
  String get opsYouDontHaveSubscriptionsNow {
    return Intl.message(
      'Ops... You don\\\'t have subscriptions now.',
      name: 'opsYouDontHaveSubscriptionsNow',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Error loading subscriber data`
  String get errorLoadingSubscriberData {
    return Intl.message(
      'Error loading subscriber data',
      name: 'errorLoadingSubscriberData',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions not found`
  String get subscriptionsNotFound {
    return Intl.message(
      'Subscriptions not found',
      name: 'subscriptionsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this subscriptions from your list?`
  String get doYouWantToDeleteThisSubscriptionsFromYourList {
    return Intl.message(
      'Do you want to delete this subscriptions from your list?',
      name: 'doYouWantToDeleteThisSubscriptionsFromYourList',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions removed successfully!`
  String get subscriptionsRemovedSuccessfully {
    return Intl.message(
      'Subscriptions removed successfully!',
      name: 'subscriptionsRemovedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Error removing subscriptions: $e`
  String get errorRemovingSubscriptionsE {
    return Intl.message(
      'Error removing subscriptions: \$e',
      name: 'errorRemovingSubscriptionsE',
      desc: '',
      args: [],
    );
  }

  /// `Avaliable plans`
  String get avaliablePlans {
    return Intl.message(
      'Avaliable plans',
      name: 'avaliablePlans',
      desc: '',
      args: [],
    );
  }

  /// `There are several plans for using CrossWays. Please choose the one that suit for trips easily`
  String get thereAreSeveralPlansForUsingCrosswaysPleaseChooseThe {
    return Intl.message(
      'There are several plans for using CrossWays. Please choose the one that suit for trips easily',
      name: 'thereAreSeveralPlansForUsingCrosswaysPleaseChooseThe',
      desc: '',
      args: [],
    );
  }

  /// `Regular`
  String get regular {
    return Intl.message(
      'Regular',
      name: 'regular',
      desc: '',
      args: [],
    );
  }

  /// `Use standard features to plan and search for trips easily`
  String get useStandardFeaturesToPlanAndSearchForTripsEasily {
    return Intl.message(
      'Use standard features to plan and search for trips easily',
      name: 'useStandardFeaturesToPlanAndSearchForTripsEasily',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe only 10 people`
  String get subscribeOnly10People {
    return Intl.message(
      'Subscribe only 10 people',
      name: 'subscribeOnly10People',
      desc: '',
      args: [],
    );
  }

  /// `Have only 10 active trips`
  String get haveOnly10ActiveTrips {
    return Intl.message(
      'Have only 10 active trips',
      name: 'haveOnly10ActiveTrips',
      desc: '',
      args: [],
    );
  }

  /// `Add photo to your profile picture`
  String get addPhotoToYourProfilePicture {
    return Intl.message(
      'Add photo to your profile picture',
      name: 'addPhotoToYourProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `You have this plan`
  String get youHaveThisPlan {
    return Intl.message(
      'You have this plan',
      name: 'youHaveThisPlan',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `Use advanced functionallity for a better user experience`
  String get useAdvancedFunctionallityForABetterUserExperience {
    return Intl.message(
      'Use advanced functionallity for a better user experience',
      name: 'useAdvancedFunctionallityForABetterUserExperience',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe unlimited number of people`
  String get subscribeUnlimitedNumberOfPeople {
    return Intl.message(
      'Subscribe unlimited number of people',
      name: 'subscribeUnlimitedNumberOfPeople',
      desc: '',
      args: [],
    );
  }

  /// `Have unlimited number of active trips`
  String get haveUnlimitedNumberOfActiveTrips {
    return Intl.message(
      'Have unlimited number of active trips',
      name: 'haveUnlimitedNumberOfActiveTrips',
      desc: '',
      args: [],
    );
  }

  /// `Add gif to your profile picture`
  String get addGifToYourProfilePicture {
    return Intl.message(
      'Add gif to your profile picture',
      name: 'addGifToYourProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `Make your account private`
  String get makeYourAccountPrivate {
    return Intl.message(
      'Make your account private',
      name: 'makeYourAccountPrivate',
      desc: '',
      args: [],
    );
  }

  /// `VIP Status`
  String get vipStatus {
    return Intl.message(
      'VIP Status',
      name: 'vipStatus',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `Manage data about yourself`
  String get manageDataAboutYourself {
    return Intl.message(
      'Manage data about yourself',
      name: 'manageDataAboutYourself',
      desc: '',
      args: [],
    );
  }

  /// `Upload new`
  String get uploadNew {
    return Intl.message(
      'Upload new',
      name: 'uploadNew',
      desc: '',
      args: [],
    );
  }

  /// `Make profile private`
  String get makeProfilePrivate {
    return Intl.message(
      'Make profile private',
      name: 'makeProfilePrivate',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get generalInformation {
    return Intl.message(
      'General information',
      name: 'generalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in at least one field to update.`
  String get pleaseFillInAtLeastOneFieldToUpdate {
    return Intl.message(
      'Please fill in at least one field to update.',
      name: 'pleaseFillInAtLeastOneFieldToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Additional data`
  String get additionalData {
    return Intl.message(
      'Additional data',
      name: 'additionalData',
      desc: '',
      args: [],
    );
  }

  /// `About yourself`
  String get aboutYourself {
    return Intl.message(
      'About yourself',
      name: 'aboutYourself',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation of deletion`
  String get confirmationOfDeletion {
    return Intl.message(
      'Confirmation of deletion',
      name: 'confirmationOfDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get areYouSureYouWantToDeleteYourAccountThis {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'areYouSureYouWantToDeleteYourAccountThis',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Find your travel               soulmate fast & easily`
  String get findYourTravelSoulmateFastEasily {
    return Intl.message(
      'Find your travel               soulmate fast & easily',
      name: 'findYourTravelSoulmateFastEasily',
      desc: '',
      args: [],
    );
  }

  /// `Cross ways and explore the world together`
  String get crossWaysAndExploreTheWorldTogether {
    return Intl.message(
      'Cross ways and explore the world together',
      name: 'crossWaysAndExploreTheWorldTogether',
      desc: '',
      args: [],
    );
  }

  /// `"CrossWays" is an international platform created to help people struggling `
  String get crosswaysIsAnInternationalPlatformCreatedToHelpPeopleStruggling {
    return Intl.message(
      '"CrossWays" is an international platform created to help people struggling ',
      name: 'crosswaysIsAnInternationalPlatformCreatedToHelpPeopleStruggling',
      desc: '',
      args: [],
    );
  }

  /// `with finding company for their trips or feeling desire to improve its planning. `
  String get withFindingCompanyForTheirTripsOrFeelingDesireTo {
    return Intl.message(
      'with finding company for their trips or feeling desire to improve its planning. ',
      name: 'withFindingCompanyForTheirTripsOrFeelingDesireTo',
      desc: '',
      args: [],
    );
  }

  /// `Developed by the group of particularly stubborn students, "CrossWays" has to offer `
  String get developedByTheGroupOfParticularlyStubbornStudentsCrosswaysHas {
    return Intl.message(
      'Developed by the group of particularly stubborn students, "CrossWays" has to offer ',
      name: 'developedByTheGroupOfParticularlyStubbornStudentsCrosswaysHas',
      desc: '',
      args: [],
    );
  }

  /// `you a lot of useful tools for satisfying work and travel planning. Keep reading to know more.`
  String get youALotOfUsefulToolsForSatisfyingWorkAnd {
    return Intl.message(
      'you a lot of useful tools for satisfying work and travel planning. Keep reading to know more.',
      name: 'youALotOfUsefulToolsForSatisfyingWorkAnd',
      desc: '',
      args: [],
    );
  }

  /// `Top opportunities for you`
  String get topOpportunitiesForYou {
    return Intl.message(
      'Top opportunities for you',
      name: 'topOpportunitiesForYou',
      desc: '',
      args: [],
    );
  }

  /// `Finding friends`
  String get findingFriends {
    return Intl.message(
      'Finding friends',
      name: 'findingFriends',
      desc: '',
      args: [],
    );
  }

  /// `Meet people to travel together!`
  String get meetPeopleToTravelTogether {
    return Intl.message(
      'Meet people to travel together!',
      name: 'meetPeopleToTravelTogether',
      desc: '',
      args: [],
    );
  }

  /// `Travel matching`
  String get travelMatching {
    return Intl.message(
      'Travel matching',
      name: 'travelMatching',
      desc: '',
      args: [],
    );
  }

  /// `Filter travels and people by our special tool!`
  String get filterTravelsAndPeopleByOurSpecialTool {
    return Intl.message(
      'Filter travels and people by our special tool!',
      name: 'filterTravelsAndPeopleByOurSpecialTool',
      desc: '',
      args: [],
    );
  }

  /// `Trip planning`
  String get tripPlanning {
    return Intl.message(
      'Trip planning',
      name: 'tripPlanning',
      desc: '',
      args: [],
    );
  }

  /// `We will help you with the "boring" stuff!`
  String get weWillHelpYouWithTheBoringStuff {
    return Intl.message(
      'We will help you with the "boring" stuff!',
      name: 'weWillHelpYouWithTheBoringStuff',
      desc: '',
      args: [],
    );
  }

  /// `Free travel advice`
  String get freeTravelAdvice {
    return Intl.message(
      'Free travel advice',
      name: 'freeTravelAdvice',
      desc: '',
      args: [],
    );
  }

  /// `We will always help you out!`
  String get weWillAlwaysHelpYouOut {
    return Intl.message(
      'We will always help you out!',
      name: 'weWillAlwaysHelpYouOut',
      desc: '',
      args: [],
    );
  }

  /// `Create a Trip`
  String get createATrip {
    return Intl.message(
      'Create a Trip',
      name: 'createATrip',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImage {
    return Intl.message(
      'Upload Image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Country :`
  String get country {
    return Intl.message(
      'Country :',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Select period`
  String get selectPeriod {
    return Intl.message(
      'Select period',
      name: 'selectPeriod',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Title :`
  String get title {
    return Intl.message(
      'Title :',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description :`
  String get description {
    return Intl.message(
      'Description :',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Member limit :`
  String get memberLimit {
    return Intl.message(
      'Member limit :',
      name: 'memberLimit',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all fields.`
  String get pleaseEnterAllFields {
    return Intl.message(
      'Please enter all fields.',
      name: 'pleaseEnterAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid member limit.`
  String get pleaseEnterAValidMemberLimit {
    return Intl.message(
      'Please enter a valid member limit.',
      name: 'pleaseEnterAValidMemberLimit',
      desc: '',
      args: [],
    );
  }

  /// `Please select dates.`
  String get pleaseSelectDates {
    return Intl.message(
      'Please select dates.',
      name: 'pleaseSelectDates',
      desc: '',
      args: [],
    );
  }

  /// `The start date cannot be in the past.`
  String get theStartDateCannotBeInThePast {
    return Intl.message(
      'The start date cannot be in the past.',
      name: 'theStartDateCannotBeInThePast',
      desc: '',
      args: [],
    );
  }

  /// `The end date must be later than the start date.`
  String get theEndDateMustBeLaterThanTheStartDate {
    return Intl.message(
      'The end date must be later than the start date.',
      name: 'theEndDateMustBeLaterThanTheStartDate',
      desc: '',
      args: [],
    );
  }

  /// `You can not have more then 5 active trips without premium status.`
  String get youCanNotHaveMoreThen5ActiveTripsWithout {
    return Intl.message(
      'You can not have more then 5 active trips without premium status.',
      name: 'youCanNotHaveMoreThen5ActiveTripsWithout',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Member limit is required`
  String get memberLimitIsRequired {
    return Intl.message(
      'Member limit is required',
      name: 'memberLimitIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Minimum 1 member required`
  String get minimum1MemberRequired {
    return Intl.message(
      'Minimum 1 member required',
      name: 'minimum1MemberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Description is required`
  String get descriptionIsRequired {
    return Intl.message(
      'Description is required',
      name: 'descriptionIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Edit Trip`
  String get editTrip {
    return Intl.message(
      'Edit Trip',
      name: 'editTrip',
      desc: '',
      args: [],
    );
  }

  /// `Start Date: ${DateFormat('dd-MM-yyyy').format(startDate!)}`
  String get startDateDateformatddmmyyyyformatstartdate {
    return Intl.message(
      'Start Date: \${DateFormat(\'dd-MM-yyyy\').format(startDate!)}',
      name: 'startDateDateformatddmmyyyyformatstartdate',
      desc: '',
      args: [],
    );
  }

  /// `End Date: ${DateFormat('dd-MM-yyyy').format(endDate!)}`
  String get endDateDateformatddmmyyyyformatenddate {
    return Intl.message(
      'End Date: \${DateFormat(\'dd-MM-yyyy\').format(endDate!)}',
      name: 'endDateDateformatddmmyyyyformatenddate',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `memberLimit`
  String get memberlimit {
    return Intl.message(
      'memberLimit',
      name: 'memberlimit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `No Title`
  String get noTitle {
    return Intl.message(
      'No Title',
      name: 'noTitle',
      desc: '',
      args: [],
    );
  }

  /// `No description available`
  String get noDescriptionAvailable {
    return Intl.message(
      'No description available',
      name: 'noDescriptionAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No Location`
  String get noLocation {
    return Intl.message(
      'No Location',
      name: 'noLocation',
      desc: '',
      args: [],
    );
  }

  /// `No trips available`
  String get noTripsAvailable {
    return Intl.message(
      'No trips available',
      name: 'noTripsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Newest trips`
  String get newestTrips {
    return Intl.message(
      'Newest trips',
      name: 'newestTrips',
      desc: '',
      args: [],
    );
  }

  /// `Request sent successfully!`
  String get requestSentSuccessfully {
    return Intl.message(
      'Request sent successfully!',
      name: 'requestSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `See more about trip`
  String get seeMoreAboutTrip {
    return Intl.message(
      'See more about trip',
      name: 'seeMoreAboutTrip',
      desc: '',
      args: [],
    );
  }

  /// `This profile is Private`
  String get thisProfileIsPrivate {
    return Intl.message(
      'This profile is Private',
      name: 'thisProfileIsPrivate',
      desc: '',
      args: [],
    );
  }

  /// `Error loading`
  String get errorLoading {
    return Intl.message(
      'Error loading',
      name: 'errorLoading',
      desc: '',
      args: [],
    );
  }

  /// `Trip updated successfully`
  String get tripUpdatedSuccessfully {
    return Intl.message(
      'Trip updated successfully',
      name: 'tripUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error updating trip`
  String get errorUpdatingTrip {
    return Intl.message(
      'Error updating trip',
      name: 'errorUpdatingTrip',
      desc: '',
      args: [],
    );
  }

  /// `Delete Trip`
  String get deleteTrip {
    return Intl.message(
      'Delete Trip',
      name: 'deleteTrip',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this trip? This action cannot be undone.`
  String get areYouSureYouWantToDeleteThisTripThis {
    return Intl.message(
      'Are you sure you want to delete this trip? This action cannot be undone.',
      name: 'areYouSureYouWantToDeleteThisTripThis',
      desc: '',
      args: [],
    );
  }

  /// `Trip deleted successfully`
  String get tripDeletedSuccessfully {
    return Intl.message(
      'Trip deleted successfully',
      name: 'tripDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting trip`
  String get errorDeletingTrip {
    return Intl.message(
      'Error deleting trip',
      name: 'errorDeletingTrip',
      desc: '',
      args: [],
    );
  }

  /// `Created by`
  String get createdBy {
    return Intl.message(
      'Created by',
      name: 'createdBy',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requests {
    return Intl.message(
      'Requests',
      name: 'requests',
      desc: '',
      args: [],
    );
  }

  /// `Nickname: ${request['nickname']}`
  String get nicknameRequestnickname {
    return Intl.message(
      'Nickname: \${request[\'nickname\']}',
      name: 'nicknameRequestnickname',
      desc: '',
      args: [],
    );
  }

  /// `Delete this trip`
  String get deleteThisTrip {
    return Intl.message(
      'Delete this trip',
      name: 'deleteThisTrip',
      desc: '',
      args: [],
    );
  }

  /// `Travel Request`
  String get travelRequest {
    return Intl.message(
      'Travel Request',
      name: 'travelRequest',
      desc: '',
      args: [],
    );
  }

  /// `Much members`
  String get muchMembers {
    return Intl.message(
      'Much members',
      name: 'muchMembers',
      desc: '',
      args: [],
    );
  }

  /// `This trip can not have more than {memberLimit} members`
  String thisTripCanNotHaveMoreThanMemberlimitMembers(int memberLimit) {
    return Intl.message(
      'This trip can not have more than $memberLimit members',
      name: 'thisTripCanNotHaveMoreThanMemberlimitMembers',
      desc: '',
      args: [memberLimit],
    );
  }

  /// `User accepted to the trip`
  String get userAcceptedToTheTrip {
    return Intl.message(
      'User accepted to the trip',
      name: 'userAcceptedToTheTrip',
      desc: '',
      args: [],
    );
  }

  /// `User request declined`
  String get userRequestDeclined {
    return Intl.message(
      'User request declined',
      name: 'userRequestDeclined',
      desc: '',
      args: [],
    );
  }

  /// `Error processing request`
  String get errorProcessingRequest {
    return Intl.message(
      'Error processing request',
      name: 'errorProcessingRequest',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Start: $startDate`
  String get startStartdate {
    return Intl.message(
      'Start: \$startDate',
      name: 'startStartdate',
      desc: '',
      args: [],
    );
  }

  /// `End: $endDate`
  String get endEnddate {
    return Intl.message(
      'End: \$endDate',
      name: 'endEnddate',
      desc: '',
      args: [],
    );
  }

  /// `People: $numberOfPeople`
  String get peopleNumberofpeople {
    return Intl.message(
      'People: \$numberOfPeople',
      name: 'peopleNumberofpeople',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe?`
  String get subscribe {
    return Intl.message(
      'Subscribe?',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to add this user to your subscriptions?`
  String get areYouSureYouWantToAddThisUserTo {
    return Intl.message(
      'Are you sure you want to add this user to your subscriptions?',
      name: 'areYouSureYouWantToAddThisUserTo',
      desc: '',
      args: [],
    );
  }

  /// `Already subscribed`
  String get alreadySubscribed {
    return Intl.message(
      'Already subscribed',
      name: 'alreadySubscribed',
      desc: '',
      args: [],
    );
  }

  /// `You are already subscribed to this user.`
  String get youAreAlreadySubscribedToThisUser {
    return Intl.message(
      'You are already subscribed to this user.',
      name: 'youAreAlreadySubscribedToThisUser',
      desc: '',
      args: [],
    );
  }

  /// `Limit reached`
  String get limitReached {
    return Intl.message(
      'Limit reached',
      name: 'limitReached',
      desc: '',
      args: [],
    );
  }

  /// `You can only have up to 10 subscriptions. Upgrade to premium to add more.`
  String get youCanOnlyHaveUpTo10SubscriptionsUpgradeTo {
    return Intl.message(
      'You can only have up to 10 subscriptions. Upgrade to premium to add more.',
      name: 'youCanOnlyHaveUpTo10SubscriptionsUpgradeTo',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully subscribed!`
  String get youHaveSuccessfullySubscribed {
    return Intl.message(
      'You have successfully subscribed!',
      name: 'youHaveSuccessfullySubscribed',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while adding the subscription: $e`
  String get anErrorOccurredWhileAddingTheSubscriptionE {
    return Intl.message(
      'An error occurred while adding the subscription: \$e',
      name: 'anErrorOccurredWhileAddingTheSubscriptionE',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile`
  String get errorUpdatingProfile {
    return Intl.message(
      'Error updating profile',
      name: 'errorUpdatingProfile',
      desc: '',
      args: [],
    );
  }

  /// `No file selected`
  String get noFileSelected {
    return Intl.message(
      'No file selected',
      name: 'noFileSelected',
      desc: '',
      args: [],
    );
  }

  /// `User is not authorized.`
  String get userIsNotAuthorized {
    return Intl.message(
      'User is not authorized.',
      name: 'userIsNotAuthorized',
      desc: '',
      args: [],
    );
  }

  /// `File size must not exceed 4 MB.`
  String get fileSizeMustNotExceed4Mb {
    return Intl.message(
      'File size must not exceed 4 MB.',
      name: 'fileSizeMustNotExceed4Mb',
      desc: '',
      args: [],
    );
  }

  /// `Animated avatars are only available to Premium users`
  String get animatedAvatarsAreOnlyAvailableToPremiumUsers {
    return Intl.message(
      'Animated avatars are only available to Premium users',
      name: 'animatedAvatarsAreOnlyAvailableToPremiumUsers',
      desc: '',
      args: [],
    );
  }

  /// `Avatar successfully updated!`
  String get avatarSuccessfullyUpdated {
    return Intl.message(
      'Avatar successfully updated!',
      name: 'avatarSuccessfullyUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Avatar upload error: $e`
  String get avatarUploadErrorE {
    return Intl.message(
      'Avatar upload error: \$e',
      name: 'avatarUploadErrorE',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `No comments yet`
  String get noCommentsYet {
    return Intl.message(
      'No comments yet',
      name: 'noCommentsYet',
      desc: '',
      args: [],
    );
  }

  /// `Write a comment...`
  String get writeAComment {
    return Intl.message(
      'Write a comment...',
      name: 'writeAComment',
      desc: '',
      args: [],
    );
  }

  /// `Rating: ${rating}`
  String ratingRating(Object rating) {
    return Intl.message(
      'Rating: \$$rating',
      name: 'ratingRating',
      desc: '',
      args: [rating],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
