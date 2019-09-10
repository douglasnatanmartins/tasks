import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseCreator {
  static DatabaseCreator _instance;
  static Database _database;

  DatabaseCreator._internal();

  factory DatabaseCreator() {
    if (_instance == null) {
      _instance = DatabaseCreator._internal();
    }

    return _instance;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initialDatabase();
    }

    return _database;
  }

  Future<Database> _initialDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'data.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  // Create database file
  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE Category(
      id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT)''');
    await db.execute('''CREATE TABLE Project(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      description TEXT,
      categoryId INTEGER NOT NULL)''');
    await db.execute('''CREATE TABLE Task(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      done INTEGER NOT NULL,
      projectId INTEGER NOT NULL,
      note TEXT)''');
    await db.execute('''CREATE TABLE Step(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      done INTEGER NOT NULL,
      taskId INTEGER NOT NULL)''');
  }
}
