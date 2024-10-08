
import 'package:roomie_radar/models/room_model.dart';
import 'package:roomie_radar/models/room_review_model.dart';
import 'package:roomie_radar/repositories/room_repository.dart';

List<Map<String,dynamic>> fakeRooms = [
  {
    "id": "1",
    "title": "Cozy Studio Apartment",
    "description": "A beautiful studio apartment located in the heart of downtown. Ideal for students and professionals.",
    "location": "New York, NY",
    "price": r"$1200/month",
    "features": ["WiFi", "Air Conditioning", "Heating", "Fully Furnished", "24/7 Security"]
  },
  {
    "id": "2",
    "title": "Spacious 2 Bedroom Apartment",
    "description": "A spacious two-bedroom apartment with a balcony and city views. Perfect for small families or roommates.",
    "location": "Los Angeles, CA",
    "price": r"$2000/month",
    "features": ["WiFi", "Swimming Pool", "Gym", "Parking", "Pet Friendly"]
  },
  {
    "id": "3",
    "title": "Modern Loft",
    "description": "Modern loft with open floor plan and high ceilings. Ideal for creatives and professionals.",
    "location": "San Francisco, CA",
    "price": r"$2500/month",
    "features": ["WiFi", "Private Balcony", "In-unit Laundry", "Pet Friendly", "Garage"]
  },
  {
    "id": "4",
    "title": "Luxury 1 Bedroom Apartment",
    "description": "Luxury one-bedroom apartment with modern amenities, located in a prime neighborhood.",
    "location": "Chicago, IL",
    "price": r"$1800/month",
    "features": ["WiFi", "Gym", "Swimming Pool", "24/7 Concierge", "Security System"]
  },
  {
    "id": "5",
    "title": "Affordable Studio Apartment",
    "description": "An affordable and clean studio apartment near public transportation and essential shops.",
    "location": "Houston, TX",
    "price": r"$900/month",
    "features": ["WiFi", "Laundry Room", "Parking", "Pet Friendly", "24/7 Security"]
  },
  {
    "id": "6",
    "title": "Beachfront Condo",
    "description": "A beautiful beachfront condo with ocean views and private beach access. Ideal for beach lovers.",
    "location": "Miami, FL",
    "price": r"$3200/month",
    "features": ["WiFi", "Swimming Pool", "Private Beach Access", "Balcony", "Parking"]
  },
  {
    "id": "7",
    "title": "Charming Cottage",
    "description": "A charming one-bedroom cottage located in a quiet, suburban neighborhood with a large backyard.",
    "location": "Austin, TX",
    "price": r"$1500/month",
    "features": ["WiFi", "Pet Friendly", "Large Yard", "Private Garage", "Air Conditioning"]
  },
  {
    "id": "8",
    "title": "Downtown Penthouse",
    "description": "A stunning penthouse with a panoramic view of the city skyline. Includes luxury amenities.",
    "location": "Seattle, WA",
    "price": r"$4500/month",
    "features": ["WiFi", "Rooftop Access", "Gym", "Swimming Pool", "24/7 Concierge"]
  },
  {
    "id": "9",
    "title": "Quiet Suburban Home",
    "description": "A peaceful three-bedroom home in a quiet neighborhood. Ideal for families or groups.",
    "location": "Orlando, FL",
    "price": r"$2200/month",
    "features": ["WiFi", "Garage", "Backyard", "Air Conditioning", "Pet Friendly"]
  },
  {
    "id": "10",
    "title": "Luxury Downtown Apartment",
    "description": "A luxurious downtown apartment with modern finishes and access to exclusive amenities.",
    "location": "Boston, MA",
    "price": r"$3500/month",
    "features": ["WiFi", "Gym", "Swimming Pool", "Parking", "24/7 Security"]
  }
];


class FakeRoomService extends RoomRepository {
  @override
  Future<void> addRoom(RoomModel room) async {
    fakeRooms.add(room.toMap());
  }

  @override
  Future<void> addRoomReview(RoomReviewModel review) async {
    // TODO: implement addRoomReview
    throw UnimplementedError();
  }

  @override
  Future<RoomModel?> fetchRoomById(String id) async {
    return RoomModel.fromMap(fakeRooms.firstWhere((room) => room["id"] == id));
  }

  @override
  Future<List<RoomReviewModel>> fetchRoomReviews(String roomId) async {
    // TODO: implement fetchRoomReviews
    throw UnimplementedError();
  }

  @override
  Future<List<RoomModel>> fetchRooms() async {
    return fakeRooms.map((room) => RoomModel.fromMap(room)).toList();
  }

}