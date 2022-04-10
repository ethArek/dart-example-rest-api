import '../../dependencies/BaseDependencies.dart';
import 'repositories/NoteRepository.dart';

class NoteDependencies {
  late NoteRepository noteRepository;

  NoteDependencies(BaseDependencies baseDependencies) {
    noteRepository = NoteRepository(baseDependencies.db);
  }
}
