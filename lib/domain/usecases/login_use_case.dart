import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  const LoginUseCase(this.repository);

  Future<AuthUser> call(String username, String password) {
    return repository.login(username, password);
  }
}

