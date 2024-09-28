import 'package:flutter/material.dart';
import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/services/fake_room_service.dart';
import 'package:roomie_radar/viewmodels/room_listing_viewmodel.dart';
import 'package:roomie_radar/views/listings/components/room_card.dart';

class RoomListing extends StatefulWidget {
  const RoomListing({super.key});

  @override
  State<RoomListing> createState() => _RoomListingState();
}

class _RoomListingState extends State<RoomListing> {
  final viewModel = RoomListingViewmodel(
    FakeRoomService(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Listing'),
      ),
      body: FutureBuilder(
          future: viewModel.fetchRooms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return RoomCard(
                    room: snapshot.data![index],
                  );
                },
              );
            }
          }),
    );
  }
}
