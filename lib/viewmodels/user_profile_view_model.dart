import 'package:roomie_radar/services/firebase/firebase_auth_service.dart'; // Adjust the import based on your structure
import 'package:roomie_radar/models/user_model.dart';

class UserProfileViewModel {
  UserModel? user;
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<void> fetchUserProfile() async {
    user = await _authService.getUserById('currentUserId'); // Replace with actual user ID logic
  }

  Future<void> updateUserProfile(String name, String bio) async {
    if (user != null) {
      // Create a new instance of UserModel with updated values
      user = UserModel(
        id: user!.id,
        name: name,
        email: user!.email,
        profilePicture: user!.profilePicture,
        bio: bio,
        reviews: user!.reviews,
        likedRooms: user!.likedRooms,
      );

      await _authService.updateUser(user!); // Call the updated method
    }
  }
}
