import 'package:roomie_radar/models/room_review_model.dart';

class Room {
  final String id; // Unique identifier for the room
  final String title; // Title of the room listing
  final String description; // Detailed description of the room
  final String location; // Location of the room
  final double price; // Price of the room
  final List<String> features; // List of features (e.g., WiFi, AC)
  final List<RoomReview> reviews; // List of reviews for the room
  final List<String>
      compatibleUsers; // List of user IDs compatible with the room

  Room({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.features,
    this.reviews = const [],
    this.compatibleUsers = const [],
  });
}
