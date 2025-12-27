import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;
  const GetUsersUseCase(this.repository);

  Future<List<User>> call(String token) => repository.getUsers(token);
}

