import 'package:roomie_radar/models/room_review_model.dart';

class RoomModel {
  final String id; // Unique identifier for the room
  final String title; // Title of the room listing
  final String description; // Detailed description of the room
  final String location; // Location of the room
  final double price; // Price of the room
  final List<String> features; // List of features (e.g., WiFi, AC)
  final List<RoomReviewModel> reviews; // List of reviews for the room
  final List<String>
      compatibleUsers; // List of user IDs compatible with the room

  RoomModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.features,
    this.reviews = const [],
    this.compatibleUsers = const [],
  });

  // Convert room data to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'price': price,
      'features': features,
      'reviews': reviews.map((review) => review.toMap()).toList(),
      'compatibleUsers': compatibleUsers,
    };
  }

  // Create a room object from a map
  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      price: map['price'],
      features: List<String>.from(map['features']),
      reviews: List<RoomReviewModel>.from(
        map['reviews'].map((review) => RoomReviewModel.fromMap(review)),
      ),
      compatibleUsers: List<String>.from(map['compatibleUsers']),
    );
  }
}
