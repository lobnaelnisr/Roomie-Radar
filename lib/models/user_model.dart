import 'package:roomie_radar/models/room_review_model.dart';

class User {
  final String id; // Unique identifier for the user
  final String name; // User's name
  final String email; // User's email
  final String profilePicture; // URL of the user's profile picture
  final List<RoomReview> reviews; // List of reviews given by the user
  final List<String> likedRooms; // List of room IDs the user likes

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    this.reviews = const [],
    this.likedRooms = const [],
  });
}
