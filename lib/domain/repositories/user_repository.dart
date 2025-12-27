import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(String token);
  Future<User> getUser(int id, String token);
}

