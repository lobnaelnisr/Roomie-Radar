import 'package:flutter/material.dart';
import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/services/firebase/firebase_room_service.dart';

class RoomDetailsViewModel {
  final FirebaseRoomService _roomService = FirebaseRoomService();
  RoomModel? room;
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchRoomById(String id) async {
    try {
      room = await _roomService.fetchRoomById(id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
