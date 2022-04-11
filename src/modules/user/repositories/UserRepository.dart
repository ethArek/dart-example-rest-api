import 'package:postgres/postgres.dart';
import '../../../lib/DB.dart';

class User {
  String id;
  String text;
  DateTime created_at;

  User(this.id, this.text, this.created_at);

  Map toJson() =>
      {'id': id, 'text': text, 'created_at': created_at.toIso8601String()};
}

class UserRepository {
  DB db;

  UserRepository(this.db);

  void create(String text) async {
    var query =
        'INSERT INTO users (text) VALUES (${PostgreSQLFormat.id('text', type: PostgreSQLDataType.text)}) RETURNING (id, text, created_at)'; // Despite RETURNING in query I cannot get values from it

    await db.connection.query(query, substitutionValues: {'text': text});
  }

  Future<User> get(String id) async {
    var query =
        'SELECT id, text, created_at FROM users WHERE id = ${PostgreSQLFormat.id('id', type: PostgreSQLDataType.uuid)}';
    var result =
        await db.connection.query(query, substitutionValues: {'id': id});

    if (result.isEmpty) {
      throw Exception('User not found');
    }

    return mapDbRow(result[0]);
  }

  Future<List<User>> list(int limit, int offset) async {
    var query =
        'SELECT id, text, created_at FROM users LIMIT $limit OFFSET $offset';

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
    return User(row[0], row[1], row[2]);
  }
}
