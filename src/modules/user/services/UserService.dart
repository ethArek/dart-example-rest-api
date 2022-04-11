import '../repositories/UserRepository.dart';

class UserService {
  UserRepository userRepository;

  UserService(this.userRepository);

  Future<User> create(
      {required String nickname, required String password}) async {
    return userRepository.create(nickname: nickname, password: password);
  }

  Future<User> get(String id) async {
    return userRepository.get(id);
  }

  Future<List<User>> list(int limit, int offset) async {
    return userRepository.list(limit, offset);
  }
}
