import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/models/room_review_model.dart';

class RoomRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RoomModel>> fetchRooms() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('rooms').get();
      return snapshot.docs
          .map((doc) => RoomModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error fetching rooms: $e");
    }
  }

  Future<RoomModel?> fetchRoomById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('rooms').doc(id).get();
      return RoomModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Error fetching room: $e");
    }
  }

  Future<void> addRoom(RoomModel room) async {
    try {
      await _firestore.collection('rooms').add(room.toMap());
    } catch (e) {
      throw Exception("Error adding room: $e");
    }
  }

  Future<void> addRoomReview(RoomReviewModel review) async {
    try {
      await _firestore.collection('room_reviews').add(review.toMap());
    } catch (e) {
      throw Exception("Error adding room review: $e");
    }
  }

  Future<List<RoomReviewModel>> fetchRoomReviews(String roomId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('room_reviews')
          .where('roomId', isEqualTo: roomId)
          .get();
      return snapshot.docs
          .map((doc) =>
              RoomReviewModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Error fetching room reviews: $e");
    }
  }
}