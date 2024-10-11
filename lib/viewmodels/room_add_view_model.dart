import 'package:flutter/material.dart';
import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/repositories/room_repository.dart';

class RoomAddViewModel extends ChangeNotifier {
  final RoomRepository _roomRepository;
  
  RoomAddViewModel(this._roomRepository);

  Future<void> addRoom(RoomModel room) async {
    try {
      await _roomRepository.addRoom(room);
      notifyListeners();
    } catch (e) {
      throw Exception("Error adding room: $e");
    }
  }
}
