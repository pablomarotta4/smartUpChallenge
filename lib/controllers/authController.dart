import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartup_challenge/models/userModel.dart';
import 'package:smartup_challenge/repository/userRepository.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  final UserRepository _userRepository = UserRepository(FirebaseFirestore.instance);

  User? get user => _user;

  AuthController() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> phoneAuthentication(String phone) async {
    await _userRepository.phoneAuthentication(phone);
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        final user = userCredential.user!;
        final userModel = UserModel(
          username: user.displayName ?? '',
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          birth: '', password: '', 
        );
        await _userRepository.createUser(userModel);
      }

      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<UserCredential?> createAccount({
    String? email,
    String? phone,
    required String password,
    required String username,
    required String birth,
    BuildContext? context,
  }) async {
    try {
      bool emailExists = email != null && await checkIfEmailExists(email);
      bool phoneExists = phone != null && await checkIfPhoneExists(phone);
      bool usernameExists = await checkIfUsernameExists(username);

      if (emailExists || phoneExists || usernameExists) {
        return Future.error('The email, phone number, or username is already in use.');
      }

      UserCredential userCredential;

      if (email != null && email.isNotEmpty) {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else if (phone != null && phone.isNotEmpty) {
        await phoneAuthentication(phone);
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: '$phone@phoneauth.com',
          password: password,
        );
      } else {
        return Future.error('Email or phone number must be provided.');
      }

      final userModel = UserModel(
        username: username,
        email: email ?? '',
        phone: phone ?? '',
        birth: birth,
        password: '',
      );

      await _userRepository.createUser(userModel);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The account already exists for that email.');
      } else {
        return Future.error(e.message ?? 'An error occurred.');
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }


  Future<bool> verifyOTP(String otp) async {
    return await _userRepository.verifyOTP(otp);
  }


  Future<bool> checkIfEmailExists(String email) async {
    return (await _userRepository.checkIfEmailExists(email)).docs.isNotEmpty;
  }

  Future<bool> checkIfPhoneExists(String phone) async {
    return (await _userRepository.checkIfPhoneExists(phone)).docs.isNotEmpty;
  }

  Future<bool> checkIfUsernameExists(String username) async {
    return (await _userRepository.checkIfUsernameExists(username)).docs.isNotEmpty;
  }

  authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<bool> checkIfEmailOrPhoneOrUsernameExists(String tokenAccess) async {
    final result = await _userRepository.checkIfEmailOrPhoneOrUsernameExists(tokenAccess);
    return result.docs.isNotEmpty;
  }

  Future<UserCredential> signInWithEmailAndPassword( {required String email, required String password}) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
