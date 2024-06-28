import 'package:cloud_firestore/cloud_firestore.dart';
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
        return UserModel(
          username: doc['username'],
          emailOrPhone: doc['emailOrPhone'],
          birth: doc['birth'],
          password: '',
          uid: doc['uid'],
          name: doc['name'],
        );
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.emailOrPhone).update(user.toMap());
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String emailOrPhone) async {
    try {
      await _firestore.collection('users').doc(emailOrPhone).delete();
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  Future<QuerySnapshot> checkIfUsernameExists(String username) async {
    return await _firestore.collection('users').where('username', isEqualTo: username).get();
  }

  Future<QuerySnapshot> checkIfEmailExists(String email) async {
    return await _firestore.collection('users').where('email', isEqualTo: email).get();
  }

  Future<QuerySnapshot> checkIfPhoneExists(String phone) async {
    return await _firestore.collection('users').where('phone', isEqualTo: phone).get();
  }

  getUserByUid(String uid) {
    return _firestore.collection('users').doc(uid).get();
  }

  getUserByEmailOrPhone(String emailOrPhone) {
    return _firestore.collection('users').doc(emailOrPhone).get();
  }
  
}
