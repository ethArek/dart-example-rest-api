import '../lib/DB.dart';

class BaseDependencies {
  late DB db;

  BaseDependencies() {
    db = DB();
  }
}
