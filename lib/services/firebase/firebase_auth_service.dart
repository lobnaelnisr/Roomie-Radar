import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roomie_radar/models/user_model.dart';
import 'package:roomie_radar/repositories/auth_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseAuthService extends AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel?> signUp(
      String email, String password, String name, File profilePic) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Upload profile picture and create user in Firestore
      String profilePictureUrl = await updateProfilePicture(
        userCredential.user!.uid,
        profilePic,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        profilePicture: profilePictureUrl,
      );

      // Store user in Firestore
      await _firestore.collection('users').doc(user.id).set(user.toMap());
      return user;
    } catch (e) {
      log("Firebase sign-up error: $e");
      throw Exception("Error signing up: $e");
    }
  }

  @override
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

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(id).get();
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception("Error fetching user: $e");
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception("Error resetting password: $e");
    }
  }

  @override
  Future<String> updateProfilePicture(String id, File profilePicture) async {
    try {
      // Upload image to Firebase Storage
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_pictures/$id.jpg');
      await ref.putFile(profilePicture);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception("Error updating profile picture: $e");
    }
  }

  // Implement the updateUserProfile method
  @override
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
    } catch (e) {
      throw Exception("Error updating user profile: $e");
    }
  }
}