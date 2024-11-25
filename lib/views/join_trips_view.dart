import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'trip_details_view.dart';

class JoinTripScreen extends StatefulWidget {
  @override
  _JoinTripScreenState createState() => _JoinTripScreenState();
}

class _JoinTripScreenState extends State<JoinTripScreen> {
  final PageController _controller = PageController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _trips = [];

  @override
  void initState() {
    super.initState();
    _fetchTrips();
  }

  Future<void> _fetchTrips() async {
    try {
      final currentUserId = _auth.currentUser?.uid;
      if (currentUserId == null) return;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Trips')
          .where('creatorId', isNotEqualTo: currentUserId)
          .get();

      setState(() {
        _trips = querySnapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
            .toList();
      });
    } catch (e) {
      log('Error fetching trips: $e');
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  void _navigateToTripDetails(Map<String, dynamic> trip) {
    final DateTime? fromDate = (trip['from'] as Timestamp?)?.toDate();
    final DateTime? toDate = (trip['to'] as Timestamp?)?.toDate();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripDetailsScreen(
          tripName: trip['title'] ?? 'No Title',
          tripDescription: trip['description'] ?? 'No description available',
          tripImageUrl: trip['imageUrl'],
          formattedStartDate: formatDate(fromDate),
          formattedEndDate: formatDate(toDate),
          country: trip['country'] ?? 'No Location',
          creator: trip['creatorId'] ?? '',
          memberLimit: trip['memberLimit'] ?? 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _trips.isEmpty
          ? const Center(
              child: Text(
                'No trips available',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : PageView.builder(
              controller: _controller,
              itemCount: _trips.length,
              itemBuilder: (context, index) {
                return _buildCard(_trips[index]);
              },
            ),
    );
  }

  Widget _buildCard(Map<String, dynamic> trip) {
    final DateTime? fromDate = (trip['from'] as Timestamp?)?.toDate();
    final DateTime? toDate = (trip['to'] as Timestamp?)?.toDate();

    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Newest trips',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 10 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  trip['imageUrl'] ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              trip['title'] ?? 'No Title',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              trip['country'] ?? 'No Location',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${formatDate(fromDate)} / ${formatDate(toDate)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red, size: 40),
                  onPressed: () {
                    // Логіка для крестику
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon:
                      const Icon(Icons.favorite, color: Colors.pink, size: 40),
                  onPressed: () {
                    // Логіка для сердечка
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _navigateToTripDetails(trip),
              child: const Text(
                'See more about trip',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.pink,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
