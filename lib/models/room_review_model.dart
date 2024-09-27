class RoomReviewModel {
  final String userId; // ID of the user who reviewed the room
  final String roomId; // ID of the room being reviewed
  final String reviewText; // Review text
  final double rating; // Rating given by the user (e.g., from 1 to 5)
  final DateTime createdAt; // Date and time when the review was created

  RoomReviewModel({
    required this.userId,
    required this.roomId,
    required this.reviewText,
    required this.rating,
    required this.createdAt,
  });

  // Convert review data to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'roomId': roomId,
      'reviewText': reviewText,
      'rating': rating,
      'createdAt': createdAt,
    };
  }

  // Create a review object from a map
  factory RoomReviewModel.fromMap(Map<String, dynamic> map) {
    return RoomReviewModel(
      userId: map['userId'],
      roomId: map['roomId'],
      reviewText: map['reviewText'],
      rating: map['rating'],
      createdAt: map['createdAt'].toDate(),
    );
  }
}
