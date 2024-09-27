import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Create user document in Firestore
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        profilePicture: "", // Default or placeholder
      );
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      return user;
    } catch (e) {
      throw Exception("Error signing up: $e");
    }
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await getUserById(userCredential.user!.uid);
    } catch (e) {
      throw Exception("Error signing in: $e");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserModel?> getUserById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(id).get();
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Error fetching user: $e");
    }
  }
}
