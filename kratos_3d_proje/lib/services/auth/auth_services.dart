import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    //try sign in user in
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
      /* if (userCredential.user!.emailVerified) {
        return userCredential;
      } else {
        _firebaseAuth.signOut();
        throw 'Please verify your account with the link sent to your email address!';
      }*/
    }

    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(
      String email, password, name, surname) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // send mail
      await userCredential.user?.sendEmailVerification();
      _firebaseAuth.signOut();
      // create or add users collection
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid);

      await userDoc.set({
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
      });
      return userCredential;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
