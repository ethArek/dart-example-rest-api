import 'UserDependencies.dart';
import 'services/UserService.dart';

class UserModule {
  late UserService userService;

  UserModule(UserDependencies userDependencies) {
    userService = UserService(userDependencies.userRepository);
  }
}
