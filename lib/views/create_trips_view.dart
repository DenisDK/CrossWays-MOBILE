import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_ways/components/custom_error_alert.dart';
import 'package:cross_ways/database/check_user_premium.dart';
import 'package:cross_ways/database/create_trip.dart';
import 'package:cross_ways/views/user_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../components/animation_route.dart';

class CreateTripScreen extends StatefulWidget {
  @override
  _CreateTripScreenState createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  File? _image;
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _memberLimitController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;
  bool isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    doesHasPremium(user!.uid);
  }

  Future<void> doesHasPremium(String userId) async {
    bool hasPremium = await checkUserPremiumStatusById(userId);
    setState(() {
      isPremiumUser = hasPremium;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 135, 100, 71),
            hintColor: const Color.fromARGB(255, 135, 100, 71),
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 135, 100, 71)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
          _fromController.text =
              "${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}";
        } else {
          _toDate = picked;
          _toController.text =
              "${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  'Create a Trip',
                  style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Upload Image',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _image == null
                    ? Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey.shade600,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Country :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                hintText: '',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor: const Color.fromARGB(255, 204, 194, 191),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select period',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fromController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'From',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, true),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _toController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'To',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, false),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Title :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor: const Color.fromARGB(255, 204, 194, 191),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor: const Color.fromARGB(255, 204, 194, 191),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Member limit :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _memberLimitController,
              decoration: InputDecoration(
                hintText: '',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                filled: true,
                fillColor: const Color.fromARGB(255, 204, 194, 191),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final country = _countryController.text;
                final title = _titleController.text;
                final description = _descriptionController.text;
                final memberLimit = int.tryParse(_memberLimitController.text);

                // Перевірка на заповненість основних полів
                if (country.isEmpty || title.isEmpty || description.isEmpty) {
                  CustomAlert.show(
                      context: context,
                      title: "Error",
                      content: "Please enter all fields.");
                  return;
                }

                if (memberLimit == null || memberLimit <= 0) {
                  CustomAlert.show(
                      context: context,
                      title: "Error",
                      content: "Please enter a valid member limit.");
                  return;
                }

                if (_fromDate == null || _toDate == null) {
                  CustomAlert.show(
                      context: context,
                      title: "Error",
                      content: "Please select dates.");
                  return;
                }

                // Перевірка на дату початку
                if (_fromDate!.isBefore(DateTime.now())) {
                  CustomAlert.show(
                      context: context,
                      title: "Error",
                      content: "The start date cannot be in the past.");
                  return;
                }

                // Перевірка на кінцеву дату
                if (_toDate!.isBefore(_fromDate!)) {
                  CustomAlert.show(
                      context: context,
                      title: "Error",
                      content:
                          "The end date must be later than the start date.");
                  return;
                }

                User? currentUser = FirebaseAuth.instance.currentUser;
                DocumentSnapshot userDoc = await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(currentUser?.uid)
                    .get();
                List activeTrips = userDoc['activeTravels'] ?? [];
                int activeTripsCount = activeTrips.length;
                if (!isPremiumUser && activeTripsCount >= 5) {
                  CustomAlert.show(
                      context: context,
                      title: "Error",
                      content:
                          "You can not have more then 5 active trips without premium status.");
                  return;
                } else {
                  await createTrip(country, _fromDate!, _toDate!, title,
                      description, _image!, memberLimit);
                  Navigator.pushReplacement(
                      context, PushPageRoute(page: UserProfileScreen()));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5C6D67),
                padding:
                    const EdgeInsets.symmetric(horizontal: 160, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Create',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
