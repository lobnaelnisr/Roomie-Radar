class RoomReview {
  final String userId; // ID of the user who reviewed the room
  final String roomId; // ID of the room being reviewed
  final String reviewText; // Review text
  final double rating; // Rating given by the user (e.g., from 1 to 5)
  final DateTime createdAt; // Date and time when the review was created

  RoomReview({
    required this.userId,
    required this.roomId,
    required this.reviewText,
    required this.rating,
    required this.createdAt,
  });
}
