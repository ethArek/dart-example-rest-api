import 'dart:convert';

import 'package:postgres/postgres.dart';
import '../../../lib/DB.dart';

class Note {
  String id;
    String userId;
  String text;
  DateTime createdAt;

  Note(this.id, this.userId, this.text, this.createdAt);

  Map toJson() =>
      {'id': id, 'userId': userId, 'text': text, 'created_at': createdAt.toIso8601String()};
}

class NoteRepository {
  DB db;

  NoteRepository(this.db);

  void create(String userId, String text) async {
    var query =
        'INSERT INTO notes (user_id, text) VALUES (${PostgreSQLFormat.id('userId', type: PostgreSQLDataType.uuid)}, ${PostgreSQLFormat.id('text', type: PostgreSQLDataType.text)}) RETURNING (id, text, created_at)'; // Despite RETURNING in query I cannot get values from it

    var result = await db.connection.query(query, substitutionValues: {'userId': userId, 'text': text});

    print(jsonEncode(result));
  }

  Future<Note> get(String id) async {
    var query =
        'SELECT id, user_id, text, created_at FROM notes WHERE id = ${PostgreSQLFormat.id('id', type: PostgreSQLDataType.uuid)}';
    var result =
        await db.connection.query(query, substitutionValues: {'id': id});

    if (result.isEmpty) {
      throw Exception('Note not found');
    }

    return mapDbRow(result[0]);
  }

  Future<List<Note>> list(int limit, int offset) async {
    var query =
        'SELECT id, user_id, text, created_at FROM notes LIMIT $limit OFFSET $offset';

    var result = await db.connection.query(query);
    if (result.isEmpty) {
      return [];
    }

    return mapDbRows(result);
  }

  List<Note> mapDbRows(List<List> rows) {
    return rows.map((row) => mapDbRow(row)).toList();
  }

  Note mapDbRow(List row) {
    return Note(row[0], row[1], row[2], row[3]);
  }
}
