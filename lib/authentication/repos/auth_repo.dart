// auth_repo.dart
import 'dart:developer' as dev;
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthRepo {
  Database? _database;

  /// Optionally, you can call [initialize()] outwardly to set up local storage.
  Future<void> initialize() async {
    await _initDatabase();
  }

  /// Initialize the local SQLite database.
  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'auth.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE user (id TEXT PRIMARY KEY, email TEXT, name TEXT)",
        );
      },
    );
    dev.log("Database initialized at $path", name: "AUTH_REPO");
  }

  /// Signs up a user with the given email, password, and name.
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        AuthUserAttributeKey.name: name,
      };
      await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(userAttributes: userAttributes),
      );
      dev.log("Sign up successful for $email", name: "AUTH_REPO");
    } on AuthException catch (e) {
      dev.log("Sign up failed: ${e.message}", name: "AUTH_REPO", error: e);
      throw Exception(e.message);
    }
  }

  /// Confirms a user’s sign-up with the confirmation code.
  Future<void> confirmSignUp({
    required String email,
    required String confirmationCode,
  }) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: confirmationCode,
      );
      dev.log("User $email confirmed sign-up successfully", name: "AUTH_REPO");
    } on AuthException catch (e) {
      dev.log("Sign-up confirmation failed: ${e.message}", name: "AUTH_REPO", error: e);
      throw Exception(e.message);
    }
  }

  /// Resends the sign-up confirmation code.
  Future<void> resendConfirmationCode({required String email}) async {
    try {
      final result = await Amplify.Auth.resendSignUpCode(username: email);
      dev.log("Verification code sent to $email: ${result.codeDeliveryDetails}", name: "AUTH_REPO");
    } on AuthException catch (e) {
      dev.log("Resend confirmation code failed: ${e.message}", name: "AUTH_REPO", error: e);
      throw Exception(e.message);
    }
  }

  /// Logs in a user with the provided email and password.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(username: email, password: password);
      if (result.isSignedIn) {
        dev.log("User $email signed in successfully", name: "AUTH_REPO");
        await _persistUserSession(email);
      } else {
        dev.log("Sign-in attempt for $email failed", name: "AUTH_REPO");
        throw Exception("Sign-in failed for unknown reasons.");
      }
    } on AuthException catch (e) {
      dev.log("Sign in failed: ${e.message}", name: "AUTH_REPO", error: e);
      throw Exception(e.message);
    }
  }

  /// Logs out the current user.
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      await _clearLocalSession();
      dev.log("User signed out successfully", name: "AUTH_REPO");
    } on AuthException catch (e) {
      dev.log("Sign out failed: ${e.message}", name: "AUTH_REPO", error: e);
      throw Exception(e.message);
    }
  }

  /// Checks if a user is already logged in.
  Future<bool> isUserLoggedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      final isSignedIn = session.isSignedIn;
      dev.log("AWS session check: User is ${isSignedIn ? 'signed in' : 'signed out'}", name: "AUTH_REPO");
      return isSignedIn;
    } catch (e) {
      dev.log("AWS session check failed, falling back to local session", name: "AUTH_REPO", error: e);
      return await _getLocalSession();
    }
  }

  /// Persists user session data locally
  Future<void> _persistUserSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    dev.log("Local session saved for $email", name: "AUTH_REPO");
  }

  /// Clears the user session data locally.
  Future<void> _clearLocalSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    dev.log("Local session cleared", name: "AUTH_REPO");
  }

  /// Retrieves the local session; uses SQLite as a fallback if SharedPreferences indicate no session.
  Future<bool> _getLocalSession() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    dev.log("SharedPreferences session check: ${isLoggedIn ? 'User is signed in' : 'User is signed out'}",
        name: "AUTH_REPO");
    if (!isLoggedIn) {
      if (_database == null) {
        await _initDatabase();
      }
      final List<Map<String, dynamic>> users = await _database!.query('user');
      if (users.isNotEmpty) {
        dev.log("SQLite session check: User data found", name: "AUTH_REPO");
        return true;
      }
    }
    return isLoggedIn;
  }
}
