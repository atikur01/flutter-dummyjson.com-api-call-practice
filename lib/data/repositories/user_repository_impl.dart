import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote_api_service.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteApiService remote;
  UserRepositoryImpl(this.remote);

  @override
  Future<List<User>> getUsers(String token) => remote.getUsers(token);

  @override
  Future<User> getUser(int id, String token) => remote.getUser(id, token);
}

