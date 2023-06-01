import 'package:sqflite/sqflite.dart';
import 'package:untitled1/data/note.dart';

class NoteManager {
  static const _databaseName = '_note.db';

  static const _databaseVersion = 1;

  Database? _database;

  List<Note> _notes = [];

  Future<void> addNote(Note note) async {
    final db = await _getDatabase();
    await db.insert(Note.tabelName, note.toRow());
    _notes.add(note);
  }

  Future<void> deleteNote(int id) async {
    final db = await _getDatabase();
    await db.delete(
        Note.tabelName,
        where: '${Note.columnId} = ?',
        whereArgs: [id]);
  }

  Future<Note> getNote(int id) async {
    final db = await _getDatabase();
    final rows = await db.query(Note.tabelName, where: '${Note.columnId} = ?', whereArgs: [id], );
    return Note.fromRow(rows.single);
  }

  Future<List<Note>> listNotes() async {
    final db = await _getDatabase();
    final rows = await db.query(Note.tabelName);
    return rows.map((row) => Note.fromRow(row)).toList();
  }

  Future<void> updateNote(int id, Note note) async {
    final db = await _getDatabase();
    await db.update(Note.tabelName, note.toRow(), where: '${Note.columnId} : ?' , whereArgs: [id] );
    _notes[id] = note;
  }

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await openDatabase(
        _databaseName,
        version: _databaseVersion,
        onCreate: (db, version) {
          final sql = '''
      CREATE TABLE ${Note.tableName} (
        ${Note.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Note.columnTitle} TEXT,
        ${Note.columnBody} TEXT NOT NULL,
        ${Note.columnColor} INTEGER NOT NULL
      )
    ''';
        },
      );
    }
    return _database!;
  }
}
