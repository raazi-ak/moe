// ignore_for_file: unused_field

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthRepository {
  Database? _database;

  /// Initialize local storage
  // ignore: unused_element
  Future<void> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'auth.db');
    _database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user (id TEXT PRIMARY KEY, email TEXT, name TEXT)",
        );
      },
      version: 1,
    );
  }

  /// Signs up a user
  Future<void> signUp({required String email, required String password, required String name}) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        AuthUserAttributeKey.name: name,
      };
      await Amplify.Auth.signUp(username: email, password: password, options: SignUpOptions(userAttributes: userAttributes));
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Confirms sign up
  Future<void> confirmSignUp({required String email, required String confirmationCode}) async {
    try {
      await Amplify.Auth.confirmSignUp(username: email, confirmationCode: confirmationCode);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Logs in a user
  Future<void> signIn({required String email, required String password}) async {
    try {
      final result = await Amplify.Auth.signIn(username: email, password: password);
      if (result.isSignedIn) {
        await _persistUserSession(email);
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Logs out the current user
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      await _clearLocalSession();
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Checks if a user is already logged in
  Future<bool> isUserLoggedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      return session.isSignedIn;
    } catch (e) {
      return await _getLocalSession();
    }
  }

  /// Saves session data locally
  Future<void> _persistUserSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
  }

  /// Clears session data locally
  Future<void> _clearLocalSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Gets session data from local storage (SQLite as fallback)
  Future<bool> _getLocalSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
