import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteApiService remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<AuthUser> login(String username, String password) {
    return remote.login(username, password);
  }
}

