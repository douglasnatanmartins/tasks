import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class LocalSource {
  static LocalSource _instance;
  static Database _database;
  final int version = 1;

  LocalSource._internal();

  factory LocalSource() {
    if (_instance == null) {
      _instance = LocalSource._internal();
    }

    return _instance;
  }

  /// Get database
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initialDatabase();
    }

    return _database;
  }

  /// Initial database.
  Future<Database> _initialDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'off.db');
    var database = await openDatabase(
      path,
      version: this.version,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    return database;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Create database file if file not exist.
  Future<void> _onCreate(Database db, int version) async {
    var batch = db.batch();

    // Create the category table.
    batch.execute('''
      CREATE TABLE Category(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        created_date TEXT NOT NULL
      )
    ''');

    // Create the project table.
    batch.execute('''
      CREATE TABLE Project(
        id INTEGER PRIMARY KEY,
        category_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        color TEXT NOT NULL,
        icon TEXT NOT NULL,
        created_date TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES Category(id) ON DELETE CASCADE
      )
    ''');

    // Create the task table.
    batch.execute('''
      CREATE TABLE Task(
        id INTEGER PRIMARY KEY,
        project_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        note TEXT,
        is_done INTEGER NOT NULL,
        is_important INTEGER NOT NULL,
        due_date TEXT,
        created_date TEXT NOT NULL,
        FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE
      )
    ''');

    // Create the step table.
    batch.execute('''
      CREATE TABLE Step(
        id INTEGER PRIMARY KEY,
        message TEXT NOT NULL,
        is_done INTEGER NOT NULL,
        task_id INTEGER NOT NULL,
        FOREIGN KEY (task_id) REFERENCES Task(id) ON DELETE CASCADE
      )
    ''');

    // Commit this batch.
    await batch.commit();
  }

  /// Upgrade database file.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Batch batch = db.batch();

    // // Commit this batch.
    // batch.commit();
  }
}
