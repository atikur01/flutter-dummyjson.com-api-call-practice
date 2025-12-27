class AuthManager {
  static AuthUserSession? currentUser;

  static bool get isLoggedIn => currentUser != null;

  static void login(AuthUserSession user) {
    currentUser = user;
  }

  static void logout() {
    currentUser = null;
  }

  static String? get token => currentUser?.accessToken;
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
}

