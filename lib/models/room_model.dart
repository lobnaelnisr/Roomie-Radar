class RoomModel {
  final String id; // Unique identifier for the room
  final String title; // Title of the room listing
  final String description; // Detailed description of the room
  final String location; // Location of the room
  final String price; // Price of the room
  final List<String> features; // List of features (e.g., WiFi, AC)


  RoomModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.features,

  });

  // Convert room data to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'price': price,
      'features': features,

    };
  }

  // Create a room object from a map
  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      price: map['price'] ,
      features: List<String>.from(map['features']),

    );
  }
}
