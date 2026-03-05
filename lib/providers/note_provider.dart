

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:notes_app/models/note.dart';


final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider chưa được khởi tạo');
});

class NoteNotifier extends Notifier<List<Note>>
{
  @override
  List<Note> build() {
     _loadNotes(); // Tải danh sách ghi chú khi khởi tạo
    return[];
  }
  
  Future<void> _loadNotes() async {
      final isar = ref.read(isarProvider);
    final notes = await isar.notes.where().findAll();
    state = notes;
  }
   Future<void> addNote(String title, String content) async {
    final isar = ref.read(isarProvider);
    final note = Note()
      ..title = title
      ..content = content
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
    await _loadNotes();
  }
   Future<void> updateNote(Note note, String title, String content) async {
    final isar = ref.read(isarProvider);
    note.title = title;
    note.content = content;

    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
    await _loadNotes();
  }
    Future<void> deleteNote(int id) async {
    final isar = ref.read(isarProvider);
    
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
    await _loadNotes();
  }
  
}
final noteProvider = NotifierProvider<NoteNotifier, List<Note>>(() {
  return NoteNotifier();
});