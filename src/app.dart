import 'package:shelf/shelf_io.dart' as shelf_io;
import 'controllers/MainController.dart';
import 'controllers/NotesController.dart';
import 'dependencies/BaseDependencies.dart';
import 'dependencies/Dependencies.dart';

void main() async {
  final baseDependencies = BaseDependencies();
  await baseDependencies.db.initConnection();
  final dependencies = Dependencies(baseDependencies);

  final notesController = NotesController(dependencies);
  final mainController = MainController(notesController);

  final server = await shelf_io.serve(mainController.handler, '0.0.0.0', 8001);
  print('Server running on localhost:${server.port}');
}
