import 'package:cross_ways/components/alert_dialog_custom.dart';
import 'package:cross_ways/components/animation_route.dart';
import 'package:cross_ways/views/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_trip_view.dart';

class TripDetailsScreen extends StatefulWidget {
  final String tripName;
  final String tripDescription;
  final String? tripImageUrl;
  final String formattedStartDate;
  final String formattedEndDate;
  final String country;
  final String creator;
  final int memberLimit;

  const TripDetailsScreen({
    Key? key,
    required this.tripName,
    required this.tripDescription,
    this.tripImageUrl,
    required this.formattedStartDate,
    required this.formattedEndDate,
    required this.country,
    required this.creator,
    required this.memberLimit,
  }) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  String? creatorNickname;
  String? currentUserNickname;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      final creatorDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.creator)
          .get();

      final currentUserDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();

      setState(() {
        creatorNickname = creatorDoc.data()?['nickname'] ?? 'Unknown';
        currentUserNickname = currentUserDoc.data()?['nickname'] ?? 'Unknown';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        creatorNickname = 'Error loading';
        currentUserNickname = 'Error loading';
        isLoading = false;
      });
    }
  }

  Future<void> _editTrip() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => EditTripDialog(
        tripDescription: widget.tripDescription,
        formattedStartDate: widget.formattedStartDate,
        formattedEndDate: widget.formattedEndDate,
        memberLimit: widget.memberLimit,
      ),
    );

    if (result != null) {
      try {
        final tripQuery = await FirebaseFirestore.instance
            .collection('Trips')
            .where('title', isEqualTo: widget.tripName)
            .where('creatorId', isEqualTo: widget.creator)
            .get();

        if (tripQuery.docs.isNotEmpty) {
          final tripDoc = tripQuery.docs.first;
          await tripDoc.reference.update({
            'description': result['description'],
            'from': result['from'],
            'to': result['to'],
            'memberLimit': result['memberLimit'],
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Trip updated successfully'),
                backgroundColor: Color(0xFF8B6857),
              ),
            );

            Navigator.pushReplacement(
              context,
              FadePageRoute(page: UserProfileScreen()),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error updating trip'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _deleteTrip() async {
    final bool? confirm = await CustomDialogAlert.showConfirmationDialog(
      context,
      'Delete Trip',
      'Are you sure you want to delete this trip? This action cannot be undone.',
    );

    if (confirm == true) {
      try {
        final tripQuery = await FirebaseFirestore.instance
            .collection('Trips')
            .where('title', isEqualTo: widget.tripName)
            .where('creatorId', isEqualTo: widget.creator)
            .get();

        if (tripQuery.docs.isNotEmpty) {
          await tripQuery.docs.first.reference.delete();

          final userDoc = FirebaseFirestore.instance
              .collection('Users')
              .doc(widget.creator);

          await userDoc.update({
            'activeTravels': FieldValue.arrayRemove([tripQuery.docs.first.id]),
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Trip deleted successfully'),
                backgroundColor: Color(0xFF8B6857),
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              FadePageRoute(page: UserProfileScreen()),
              (route) => false,
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error deleting trip'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  bool get isCreator => !isLoading && creatorNickname == currentUserNickname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tripName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B6857),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: widget.tripImageUrl != null
                        ? Image.network(
                            widget.tripImageUrl!,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image, size: 100),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoLabel(
                              label: 'Country',
                              value: widget.country,
                            ),
                            const SizedBox(height: 16),
                            InfoLabel(
                              label: 'Created by',
                              value: isLoading
                                  ? 'Loading...'
                                  : creatorNickname ?? 'Unknown',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoLabel(
                              label: 'Date',
                              value:
                                  "${widget.formattedStartDate}/${widget.formattedEndDate}",
                            ),
                            const SizedBox(height: 10),
                            InfoLabel(
                              label: 'Member limit',
                              value: "${widget.memberLimit}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "About",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B6857),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(101, 245, 196, 174),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.tripDescription,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 97, 53, 31),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  if (isCreator) ...[
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B6857),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                _editTrip();
                              },
                              child: const Text(
                                "Edit trip",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5C6D67),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                _deleteTrip();
                              },
                              child: const Text(
                                "Delete this trip",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B6857),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            // Travel request functionality
                          },
                          child: const Text(
                            "Travel Request",
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
      ),
    );
  }
}

class InfoLabel extends StatelessWidget {
  final String label;
  final String value;

  const InfoLabel({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B6857),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17.5,
            color: Color.fromARGB(255, 163, 112, 86),
          ),
        ),
      ],
    );
  }
}
