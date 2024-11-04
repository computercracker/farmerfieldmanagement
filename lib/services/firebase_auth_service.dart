import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to initialize Firebase
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // Method for signing in a user
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the signed-in user
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e); // Handle specific Firebase exceptions
    } catch (e) {
      throw Exception('An error occurred during sign in: $e');
    }
  }

  // Method for signing up a new user
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the signed-up user
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e); // Handle specific Firebase exceptions
    } catch (e) {
      throw Exception('An error occurred during sign up: $e');
    }
  }

  // Method to sign out the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Method to get the current user
  User? get currentUser => _auth.currentUser;

  // Method to reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e); // Handle specific Firebase exceptions
    } catch (e) {
      throw Exception('An error occurred while resetting password: $e');
    }
  }

  // Method to update user profile
  Future<void> updateUserProfile({String? displayName, String? photoURL}) async {
    try {
      User? user = currentUser;
      if (user != null) {
        await user.updateProfile(displayName: displayName, photoURL: photoURL);
        await user.reload(); // Reload user data to get updated info
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e); // Handle specific Firebase exceptions
    } catch (e) {
      throw Exception('An error occurred while updating profile: $e');
    }
  }

  // Method to get authentication state stream
  Stream<User?> get userStateChanges => _auth.authStateChanges();

  // Method to handle FirebaseAuth exceptions and provide user-friendly messages
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'The user corresponding to the given email has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      default:
        return 'An undefined error occurred.';
    }
  }
}
