import '../../dependencies/BaseDependencies.dart';
import 'repositories/UserRepository.dart';

class UserDependencies {
  late UserRepository userRepository;

  UserDependencies(BaseDependencies baseDependencies) {
    userRepository = UserRepository(baseDependencies.db);
  }
}
