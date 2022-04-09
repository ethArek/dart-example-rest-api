import '../repositories/NoteRepository.dart';

class NoteService {
  NoteRepository noteRepository;

  NoteService(this.noteRepository);

  create(String text) async {
    return noteRepository.create(text);
  }

  get(String id) async {
    return noteRepository.get(id);
  }

  list(int limit, int offset) async {
    return noteRepository.list(limit, offset);
  }
}
