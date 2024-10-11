class Compatibility {
  final String user1Id; // ID of the first user
  final String user2Id; // ID of the second user
  final double percentage; // Compatibility percentage

  Compatibility({
    required this.user1Id,
    required this.user2Id,
    required this.percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'user1Id': user1Id,
      'user2Id': user2Id,
      'percentage': percentage,
    };
  }
}
