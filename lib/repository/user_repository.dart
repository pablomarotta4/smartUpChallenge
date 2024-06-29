import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartup_challenge/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.emailOrPhone).set(user.toMap());
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  Future<UserModel?> getUser(String emailOrPhone) async {
    try {
      final doc = await _firestore.collection('users').doc(emailOrPhone).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          return UserModel.fromMap(data);
        } else {
          print('Document data is null for emailOrPhone: $emailOrPhone');
        }
      } else {
        print('No document found for emailOrPhone: $emailOrPhone');
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      throw Exception('Error getting user: $e');
    }
  }


  Future<UserModel?> getUserByUid(String uid) async {
    try {
      final querySnapshot = await _firestore.collection('users').where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        return UserModel.fromMap(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user by UID: $e');
    }
  }

  Future<bool> checkIfUsernameExists(String username) async {
    try {
      final querySnapshot = await _firestore.collection('users').where('username', isEqualTo: username).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking if username exists: $e');
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    try {
      final querySnapshot = await _firestore.collection('users').where('email or phone', isEqualTo: email).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking if email exists: $e');
    }
  }

  Future<bool> checkIfPhoneExists(String phone) async {
    try {
      final querySnapshot = await _firestore.collection('users').where('email or phone', isEqualTo: phone).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking if phone exists: $e');
    }
  }

}
