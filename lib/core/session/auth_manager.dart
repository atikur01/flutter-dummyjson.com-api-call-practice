import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;
  AuthManager._internal();

  final _storage = const FlutterSecureStorage();
  static const _userSessionKey = 'user_session';

  static AuthUserSession? currentUser;

  static bool get isLoggedIn => currentUser != null;

  static String? get token => currentUser?.accessToken;

  // Initialize and load session from secure storage
  Future<void> init() async {
    await loadSession();
  }

  // Clear session from secure storage
  Future<void> logout() async {
    currentUser = null;
    await _storage.delete(key: _userSessionKey);
  }

  // Load session from secure storage
  Future<void> loadSession() async {
    try {
      final sessionJson = await _storage.read(key: _userSessionKey);
      if (sessionJson != null) {
        final sessionMap = json.decode(sessionJson);
        currentUser = AuthUserSession.fromJson(sessionMap);
      }
    } catch (e) {
      // If there's an error loading the session, clear it
      await logout();
    }
  }

  // Save session to secure storage
  Future<void> login(AuthUserSession user) async {
    currentUser = user;
    final sessionJson = json.encode(user.toJson());
    await _storage.write(key: _userSessionKey, value: sessionJson);
  }

  // Check if user is logged in
  Future<bool> checkAuthStatus() async {
    await loadSession();
    return isLoggedIn;
  }

  // Legacy static methods for backward compatibility
  static void loginSync(AuthUserSession user) {
    currentUser = user;
    // Fire and forget the async save
    AuthManager()._storage.write(
      key: _userSessionKey,
      value: json.encode(user.toJson()),
    );
  }

  static void logoutSync() {
    currentUser = null;
    // Fire and forget the async delete
    AuthManager()._storage.delete(key: _userSessionKey);
  }
}

class AuthUserSession {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  const AuthUserSession({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory AuthUserSession.fromJson(Map<String, dynamic> json) {
    return AuthUserSession(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
