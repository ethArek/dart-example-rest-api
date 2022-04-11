import '../repositories/UserRepository.dart';

class UserService {
  UserRepository userRepository;

  UserService(this.userRepository);

  void create(String text) async {
    return userRepository.create(text);
  }

  Future<User> get(String id) async {
    return userRepository.get(id);
  }

  Future<List<User>> list(int limit, int offset) async {
    return userRepository.list(limit, offset);
  }
}
