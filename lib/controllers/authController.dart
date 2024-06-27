import 'dart:ffi';

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
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: '$phone@phoneauth.com', // truco
          password: password,
        );
      } else {
        return Future.error('Email or phone number must be provided.');
      }

      final userModel = UserModel(
        username: username,
        email: email ?? '',
        phone: phone ?? '',
        birth: birth, password: '',
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

  Future<bool> checkIfEmailExists(String email) async {
    final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  }

  Future<bool> checkIfPhoneExists(String phone) async {
    final QuerySnapshot result = await _userRepository.checkIfPhoneExists(phone);
    return result.docs.isNotEmpty;
  }

  Future<bool> checkIfUsernameExists(String username) async {
    final QuerySnapshot result = await _userRepository.checkIfUsernameExists(username);
    return result.docs.isNotEmpty;
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> checkIfEmailOrPhoneOrUsernameExists({String? email, String? phone, String? username}) async {
    if (email != null && email.isNotEmpty) {
      return await checkIfEmailExists(email);
    } else if (phone != null && phone.isNotEmpty) {
      return await checkIfPhoneExists(phone);
    } else if (username != null && username.isNotEmpty) {
      return await checkIfUsernameExists(username);
    } else {
      return false;
    }
  }
}
