// import 'dart:async' show Future;
// import 'package:shelf_router/shelf_router.dart';
// import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import './controllers/HomeController.dart';
import './modules/note/repositories/NoteRepository.dart';
import 'lib/DB.dart';

void main() async {
  // Variable for PORT

  DB db = DB();
  await db.initConnection();
  NoteRepository noteRepository = NoteRepository(db);

  var note = await noteRepository.get('7211418c-2c72-4c6b-a449-5b36c86f5c16');
  print(note);

  // //Instantiate Home Controller
  // final home = HomeController();
  // // Create server
  // final server = await shelf_io.serve(home.handler, '0.0.0.0', 7777);
  // // Server on message
  // print('☀️ Server running on localhost:${server.port} ☀️');
}
