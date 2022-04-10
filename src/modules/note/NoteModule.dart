import 'NoteDependencies.dart';
import 'services/NoteService.dart';

class NoteModule {
  late NoteService noteService;

  NoteModule(NoteDependencies noteDependencies) {
    noteService = NoteService(noteDependencies.noteRepository);
  }
}
