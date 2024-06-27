import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartup_challenge/models/userModel.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

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
          password: '', // No almacenes la contraseña
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          birth: '', // La fecha de nacimiento se puede pedir después
        );
        await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
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
      UserCredential userCredential;

      if (email != null && email.isNotEmpty) {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else if (phone != null && phone.isNotEmpty) {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: '$phone@phoneauth.com', // Esto es un truco para usar el número de teléfono como correo
          password: password,
        );
      } else {
        return Future.error('Email or phone number must be provided.');
      }

      final userModel = UserModel(
        username: username,
        password: password, // No almacenes la contraseña
        email: email ?? '',
        phone: phone ?? '',
        birth: birth,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set(userModel.toMap());

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

  Future<bool> checkIfEmailOrPhoneOrUsernameExists({
    String? email,
    String? phone,
    String? username,
  }) async {
    try {
      if (email != null && email.isNotEmpty) {
        final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
        return signInMethods.isNotEmpty;
      } else if (phone != null && phone.isNotEmpty) {
        // Implementar la lógica de verificación de teléfono si es necesario
        return false;
      } else if (username != null && username.isNotEmpty) {
        final QuerySnapshot result = await _firestore.collection('users').where('username', isEqualTo: username).get();
        return result.docs.isNotEmpty;
      }
      return false;
    } catch (e) {
      print('Error checking if email, phone, or username exists: $e');
      return false;
    }
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
