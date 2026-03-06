import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:notes_app/models/note.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider chưa được khởi tạo');
});

class NoteNotifier extends Notifier<List<Note>> {
  @override
  List<Note> build() {
    _loadNotes();
    return [];
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

  Future<void> toggleFavorite(Note note) async {
    final isar = ref.read(isarProvider);
    note.isFavorite = !note.isFavorite;

    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
    await _loadNotes();
  }
}

final noteProvider = NotifierProvider<NoteNotifier, List<Note>>(() {
  return NoteNotifier();
});

final favoriteNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(noteProvider);
  return notes.where((note) => note.isFavorite).toList();
});

final groupedNotesProvider = Provider<Map<String, List<Note>>>((ref) {
  final notes = ref.watch(noteProvider);
  return _groupNotes(notes);
});

final groupedFavoriteNotesProvider = Provider<Map<String, List<Note>>>((ref) {
  final notes =
      ref.watch(noteProvider).where((note) => note.isFavorite).toList();
  return _groupNotes(notes);
});

Map<String, List<Note>> _groupNotes(List<Note> notes) {
  final sortedNotes = List<Note>.from(notes)
    ..sort((a, b) => (b.createdAt ?? DateTime.now())
        .compareTo(a.createdAt ?? DateTime.now()));

  final Map<String, List<Note>> grouped = {};
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  for (final note in sortedNotes) {
    if (note.createdAt == null) continue;
    final noteDate = DateTime(
        note.createdAt!.year, note.createdAt!.month, note.createdAt!.day);
    final difference = today.difference(noteDate).inDays;

    String category;
    if (difference == 0)
      category = "Hôm nay";
    else if (difference == 1)
      category = "Hôm qua";
    else if (difference <= 7)
      category = "7 ngày trước";
    else if (difference <= 30)
      category = "30 ngày trước";
    else
      category = "Tháng ${noteDate.month}, ${noteDate.year}";

    if (!grouped.containsKey(category)) grouped[category] = [];
    grouped[category]!.add(note);
  }
  return grouped;
}

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => "";
  void setQuery(String query) => state = query;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(() => SearchQueryNotifier());

final searchResultsProvider = Provider<List<Note>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  if (query.isEmpty) return [];

  final notes = ref.watch(noteProvider);
  return notes.where((note) {
    final titleMatch = note.title?.toLowerCase().contains(query) ?? false;
    final contentMatch = note.content?.toLowerCase().contains(query) ?? false;
    return titleMatch || contentMatch;
  }).toList();
});
