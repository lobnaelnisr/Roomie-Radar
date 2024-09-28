import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/repositories/room_repository.dart';

class RoomListingViewmodel {
  final RoomRepository _roomRepository;

  RoomListingViewmodel(this._roomRepository);

  Future<List<RoomModel>> fetchRooms() async {
    try {
      return await _roomRepository.fetchRooms();
    } catch (e) {
      throw Exception("Error fetching rooms: $e");
    }
  }
}