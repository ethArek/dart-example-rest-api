import 'package:postgres/postgres.dart';
import '../../../lib/DB.dart';

class User {
  String id;
  String nickname;
  String password;
  DateTime createdAt;

  User(this.id, this.nickname, this.password, this.createdAt);

  Map toJson() => {
        'id': id,
        'nickname': nickname,
        'created_at': createdAt.toIso8601String()
      };
}

class UserRepository {
  DB db;

  UserRepository(this.db);

  void create({required String nickname, required String password}) async {
    var query =
        'INSERT INTO users (nickname, password) VALUES (${PostgreSQLFormat.id('nickname', type: PostgreSQLDataType.varChar)}, ${PostgreSQLFormat.id('password', type: PostgreSQLDataType.varChar)}) RETURNING (id, text, created_at)';

    await db.connection.query(query,
        substitutionValues: {'nickname': nickname, 'password': password});
  }

  Future<User> get(String id) async {
    var query =
        'SELECT id, nickname, password, created_at FROM users WHERE id = ${PostgreSQLFormat.id('id', type: PostgreSQLDataType.uuid)}';
    var result =
        await db.connection.query(query, substitutionValues: {'id': id});

    if (result.isEmpty) {
      throw Exception('User not found');
    }

    return mapDbRow(result[0]);
  }

  Future<List<User>> list(int limit, int offset) async {
    var query =
        'SELECT id, nickname, password, created_at FROM users LIMIT $limit OFFSET $offset';

    var result = await db.connection.query(query);
    if (result.isEmpty) {
      return [];
    }

    return mapDbRows(result);
  }

  List<User> mapDbRows(List<List> rows) {
    return rows.map((row) => mapDbRow(row)).toList();
  }

  User mapDbRow(List row) {
    return User(row[0], row[1], row[2], row[3]);
  }
}
