import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:first_app/database_helper.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('assignments.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<List<Map<String, dynamic>>> getAssignmentsBySubject(
      String subject) async {
    final db = await database;
    return await db
        .query('assignments', where: 'subject = ?', whereArgs: [subject]);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE assignments (
      id $idType,
  name $textType,
  maxPoints $intType,
  earnedPoints $intType,
  subject $textType
    )
    ''');
  }

  Future<int> createAssignment(Map<String, dynamic> assignment) async {
    final db = await instance.database;
    return await db.insert('assignments', assignment);
  }

  Future<List<Map<String, dynamic>>> getAssignments() async {
    final db = await instance.database;
    return await db.query('assignments');
  }

  Future<int> updateAssignment(Map<String, dynamic> assignment) async {
    final db = await instance.database;
    return await db.update('assignments', assignment,
        where: 'id = ?', whereArgs: [assignment['id']]);
  }

  Future<int> deleteAssignment(int id) async {
    final db = await instance.database;
    return await db.delete('assignments', where: 'id = ?', whereArgs: [id]);
  }
}
