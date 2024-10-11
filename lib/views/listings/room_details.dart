import 'package:flutter/material.dart';
import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/services/firebase/firebase_room_service.dart';

class RoomDetailsView extends StatefulWidget {
  final String roomId;

  const RoomDetailsView({required this.roomId, super.key});

  @override
  State<RoomDetailsView> createState() => _RoomDetailsViewState();
}

class _RoomDetailsViewState extends State<RoomDetailsView> {
  final FirebaseRoomService _roomService = FirebaseRoomService();
  RoomModel? room;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchRoomDetails();
  }

  Future<void> _fetchRoomDetails() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final fetchedRoom = await _roomService.fetchRoomById(widget.roomId);

      setState(() {
        room = fetchedRoom;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching room details: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Details"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : room == null
                  ? const Center(child: Text("Room not found"))
                  : _buildRoomDetails(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // Improved room details layout
  Widget _buildRoomDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRoomImage(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoomHeader(room!),
                const SizedBox(height: 20),
                _buildRoomDescription(room!),
                const SizedBox(height: 20),
                _buildRoomFeatures(room!),
                const SizedBox(height: 20),
                _buildRoomPrice(room!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Temporary network image
  Widget _buildRoomImage() {
    return Image.asset(
      'assets/room_placeholder.jpg',
      fit: BoxFit.cover,
      height: 200,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey,
          height: 200,
          child: const Center(
            child: Text(
              'Image Not Available',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // Room title and location
  Widget _buildRoomHeader(RoomModel room) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          room.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              room.location,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Room description section
  Widget _buildRoomDescription(RoomModel room) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          room.description,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  // Room features section
  Widget _buildRoomFeatures(RoomModel room) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Features:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: room.features
              .map(
                (feature) => Chip(
                  label: Text(feature),
                  backgroundColor: Colors.orange.shade200,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Room price section
  Widget _buildRoomPrice(RoomModel room) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Price:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            room.price,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  // Bottom bar with a 'Book Now' button
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Action for booking
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.orange,
        ),
        child: const Text(
          'Book Now',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
