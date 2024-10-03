import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> signUp(String email, String password, String name);
  Future<UserModel?> signIn(String email, String password);
  Future<void> signOut();
}
