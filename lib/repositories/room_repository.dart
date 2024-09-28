import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/models/room_review_model.dart';

abstract class RoomRepository {
  Future<List<RoomModel>> fetchRooms();
  Future<RoomModel?> fetchRoomById(String id);
  Future<void> addRoom(RoomModel room);
  Future<void> addRoomReview(RoomReviewModel review);
  Future<List<RoomReviewModel>> fetchRoomReviews(String roomId);
}
