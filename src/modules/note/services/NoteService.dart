import '../repositories/NoteRepository.dart';

class NoteService {
  NoteRepository noteRepository;

  NoteService(this.noteRepository);

  void create({required String userId, required String text }) async {
    return noteRepository.create(userId, text);
  }

  Future<Note> get(String id) async {
    return noteRepository.get(id);
  }

  Future<List<Note>> list(int limit, int offset) async {
    return noteRepository.list(limit, offset);
  }
}
