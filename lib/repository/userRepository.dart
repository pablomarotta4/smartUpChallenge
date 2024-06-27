import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartup_challenge/models/userModel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<UserModel> firebaseUser;
  var verificationId = ''.obs;

  UserRepository(this._firestore);

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.email).set(user.toMap());
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final doc = await _firestore.collection('users').doc(email).get();
      if (doc.exists) {
        return UserModel(
          username: doc['username'],
          email: doc['email'],
          phone: doc['phone'],
          birth: doc['birth'],
          password: '',
        );
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  Future<UserModel?> getUserByPhone(String phone) async {
    try {
      final result = await _firestore.collection('users').where('phone', isEqualTo: phone).get();
      if (result.docs.isNotEmpty) {
        final doc = result.docs.first;
        return UserModel(
          username: doc['username'],
          email: doc['email'],
          phone: doc['phone'],
          birth: doc['birth'],
          password: '',
        );
      }
      return null;
    } catch (e) {
      throw Exception('Error getting user by phone: $e');
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

  Future<QuerySnapshot> checkIfEmailOrPhoneOrUsernameExists(String tokenAccess) async {
    if (tokenAccess.contains('@')) {
      return await _firestore.collection('users').where('email', isEqualTo: tokenAccess).get();
    } else if (tokenAccess.contains('+')) {
      return await _firestore.collection('users').where('phone', isEqualTo: tokenAccess).get();
    } else {
      return await _firestore.collection('users').where('username', isEqualTo: tokenAccess).get();
    }
  }

  Future<void> phoneAuthentication(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (credentials) async {
        await _auth.signInWithCredential(credentials);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
        print('Verification code sent. Verification ID: $verificationId');
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid');
        } else {
          Get.snackbar('Error', 'An error occurred while verifying the phone number');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId.value,
      smsCode: otp,
    ));
    return credentials.user != null ? true : false;
  }
}
