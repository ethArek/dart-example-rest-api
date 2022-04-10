import '../modules/note/NoteDependencies.dart';
import '../modules/note/NoteModule.dart';
import 'BaseDependencies.dart';

class Dependencies {
  late NoteModule noteModule;

  Dependencies(BaseDependencies baseDependencies) {
    var noteDependencies = NoteDependencies(baseDependencies);
    noteModule = NoteModule(noteDependencies);
  }
}
