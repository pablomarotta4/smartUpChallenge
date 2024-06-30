import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:smartup_challenge/models/user_model.dart';
import 'package:smartup_challenge/repository/user_repository.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  final UserRepository _userRepository = UserRepository(FirebaseFirestore.instance);

  User? get user => _user;

  AuthController() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) async {
    _user = user;
    notifyListeners();
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // Si el usuario cancela el proceso de inicio de sesión.
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
          username: _generateUsername(user.displayName ?? '', user.metadata.creationTime.toString()),
          emailOrPhone: user.email ?? user.phoneNumber ?? '',
          birth: '',
          password: '',
          uid: user.uid,
          name: user.displayName ?? '',
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
    _user = null;
    notifyListeners();
  }

  Future<UserCredential?> createAccount({
    required String emailOrPhone,
    required String password,
    required String username,
    required String birth,
    required BuildContext context,
  }) async {
    try {
      bool emailExists = emailOrPhone.contains('@') ? await checkIfEmailExists(emailOrPhone) : false;
      bool phoneExists = emailOrPhone.contains('@') ? false : await checkIfPhoneExists(emailOrPhone);
      bool usernameExists = await checkIfUsernameExists(username);

      if (emailExists || phoneExists || usernameExists) {
        return Future.error('The email, phone number, or username is already in use.');
      }

      UserCredential? userCredential;

      if (emailOrPhone.contains('@')) {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailOrPhone,
          password: password,
        );
      } else if (emailOrPhone.contains("+") && emailOrPhone.isNotEmpty) {
        await _auth.verifyPhoneNumber(
          phoneNumber: emailOrPhone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            final userCredential = await _auth.signInWithCredential(credential);
            if (userCredential.user != null) {
              final userModel = UserModel(
                username: _generateUsername(username, birth),
                emailOrPhone: emailOrPhone,
                birth: birth,
                password: '',
                uid: userCredential.user!.uid,
                name: username,
              );
              await _userRepository.createUser(userModel);
            }
          },
          verificationFailed: (FirebaseAuthException error) {
            throw Exception(error.message ?? 'Verification failed');
          },
          codeSent: (String verificationId, int? forceResendingToken) {
            // Aquí podrías redirigir a la página de verificación de teléfono
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            return;
          },
        );
      } else {
        return Future.error('Email or phone number must be provided.');
      }

      if (userCredential != null && userCredential.user != null) {
        final userModel = UserModel(
          username: _generateUsername(username, birth),
          emailOrPhone: emailOrPhone,
          birth: birth,
          password: '',
          uid: userCredential.user!.uid,
          name: username,
        );

        await _userRepository.createUser(userModel);
      }

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

  String _generateUsername(String name, String birth) {
    String formattedName = name.toLowerCase().replaceAll(' ', '');
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddHHmm').format(now);
    return '$formattedName$formattedDate';
  }

  Future<bool> checkIfEmailExists(String email) async {
    return await _userRepository.checkIfEmailExists(email);
  }

  Future<bool> checkIfPhoneExists(String phone) async {
    return await _userRepository.checkIfPhoneExists(phone);
  }

  Future<bool> checkIfUsernameExists(String username) async {
    return await _userRepository.checkIfUsernameExists(username);
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    _user = userCredential.user;
    notifyListeners();
    return userCredential;
  }

  Future<String?> getUserUsername(String uid) async {
    try {
      final userDoc = await _userRepository.getUserUsername(uid);
      return userDoc;
        } catch (e) {
      print("Error getting username: $e");
    }
    return null;
  }

  Future<String> getUserName(String uid) async {
    try {
      final userDoc = await _userRepository.getUserName(uid);
      return userDoc;
        } catch (e) {
      print("Error getting username: $e");
    }
    return '';
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
