// import 'dart:async' show Future;
// import 'package:shelf_router/shelf_router.dart';
// import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'controllers/MainController.dart';
import './modules/note/repositories/NoteRepository.dart';
import 'controllers/NotesController.dart';
import 'lib/DB.dart';
import 'modules/note/services/NoteService.dart';

void main() async {
  // Variable for PORT

  final db = DB();
  await db.initConnection();
  final noteRepository = NoteRepository(db);
  final noteService = NoteService(noteRepository);
  final notesController = NotesController(noteService);

  final mainController = MainController(notesController);

  final server = await shelf_io.serve(mainController.handler, '0.0.0.0', 8000);
  print('Server running on localhost:${server.port}');
}
