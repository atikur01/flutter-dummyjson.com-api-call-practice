import '../data/datasources/remote_api_service.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/usecases/get_user_use_case.dart';
import '../domain/usecases/get_users_use_case.dart';
import '../domain/usecases/login_use_case.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late final RemoteApiService _remoteApiService;
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  late final LoginUseCase loginUseCase;
  late final GetUsersUseCase getUsersUseCase;
  late final GetUserUseCase getUserUseCase;

  void init() {
    _remoteApiService = RemoteApiService();
    _authRepository = AuthRepositoryImpl(_remoteApiService);
    _userRepository = UserRepositoryImpl(_remoteApiService);

    loginUseCase = LoginUseCase(_authRepository);
    getUsersUseCase = GetUsersUseCase(_userRepository);
    getUserUseCase = GetUserUseCase(_userRepository);
  }
}

