import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;
  const GetUserUseCase(this.repository);

  Future<User> call(int id, String token) => repository.getUser(id, token);
}

