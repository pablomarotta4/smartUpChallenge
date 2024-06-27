import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
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

  Future createAccount({String? email, String? phone, String? username, required String password}) async {
    try {
      if (email != null && email.isNotEmpty) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore.collection('users').doc(userCredential.user!.uid).set({'username': username});
        return userCredential;
      } else if (phone != null && phone.isNotEmpty) {
        return await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print('Phone number verification failed: ${e.message}');
          },
          codeSent: (String verificationId, int? resendToken) {
            // se necesita enviar el codigo de telefono
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } else {
        return 'Email, phone number, or username must be provided.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e;
    }
  }

  Future<bool> checkIfEmailOrPhoneOrUsernameExists({String? email, String? phone, String? username}) async {
    try {
      if (email != null && email.isNotEmpty) {
        final List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
        print('Sign-in methods for $email: $signInMethods'); 
        return signInMethods.isNotEmpty;
      } else if (phone != null && phone.isNotEmpty) {
        // Implementar
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
}
