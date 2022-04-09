import 'package:postgres/postgres.dart';

class DB {
  late PostgreSQLConnection connection;

  initConnection() async {
    var connection = PostgreSQLConnection("localhost", 5432, "note_db",
        username: "postgres", password: "postgres");
    await connection.open();

    this.connection = connection;
  }
}
