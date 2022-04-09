// import 'dart:async' show Future;
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import '../../../lib/DB.dart';
// import 'package:shelf/shelf_io.dart' as shelf_io;

class Note {
  String id;
  String text;
  String created_at;

  Note(this.id, this.text, this.created_at);
}

class NoteRepository {
  DB db;

  NoteRepository(this.db);

  create(String text) async {
    var query =
        'INSERT INTO notes (text) VALUES (${PostgreSQLFormat.id('text', type: PostgreSQLDataType.text)}) RETURNING (id, text, created_at)'; // Despite RETURNING in query I cannot get values from it

        await db.connection.query(query, substitutionValues: {'text': text});
  }

  get(String id) async {
    var query =
        'SELECT id, text, created_at FROM notes WHERE id = ${PostgreSQLFormat.id('id', type: PostgreSQLDataType.uuid)}';
    var result =
        await db.connection.query(query, substitutionValues: {'id': id});

    if (result.isEmpty) {
      throw Exception('Note not found');
    }

    return mapDbRow(result[0]);
  }

  list(int limit, int offset) async {
    var query =
        'SELECT id, text, created_at FROM notes LIMIT $limit OFFSET $offset';


    var result = await db.connection.query(query);
    if (result.isEmpty) {
      throw Exception('Note not found');
    }
    
    return mapDbRows(result);
  }

  List<Note> mapDbRows(List<List> rows) {
    return rows.map((row) => mapDbRow(row)).toList();
  }

  Note mapDbRow(List row) {
    return Note(row[0], row[1], row[2]);
  }
}
