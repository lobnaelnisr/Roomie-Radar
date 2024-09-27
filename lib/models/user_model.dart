import 'package:roomie_radar/models/room_review_model.dart';

class UserModel {
  final String id; // Unique identifier for the user
  final String name; // User's name
  final String email; // User's email
  final String profilePicture; // URL of the user's profile picture
  final List<RoomReviewModel> reviews; // List of reviews given by the user
  final List<String> likedRooms; // List of room IDs the user likes

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    this.reviews = const [],
    this.likedRooms = const [],
  });

  // Convert user data to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'reviews': reviews.map((review) => review.toMap()).toList(),
      'likedRooms': likedRooms,
    };
  }

  // Create a user object from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePicture: map['profilePicture'],
      reviews: List<RoomReviewModel>.from(
        map['reviews'].map((review) => RoomReviewModel.fromMap(review)),
      ),
      likedRooms: List<String>.from(map['likedRooms']),
    );
  }
}
