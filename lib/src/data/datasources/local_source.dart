import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class LocalSource {
  static LocalSource _instance;
  static Database _database;

  LocalSource._internal();

  factory LocalSource() {
    if (_instance == null) {
      _instance = LocalSource._internal();
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
    var database = await openDatabase(
      path,
      version: 3,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade
    );
    return database;
  }

  void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Create database file.
  void _onCreate(Database db, int version) async {
    var batch = db.batch();
    this._createTables(batch);
    // Commit this batch.
    await batch.commit();
  }

  /// Upgrade database file.
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();

    // When old version less 2.
    if (oldVersion < 2) {
      batch.execute('DROP TABLE IF EXISTS Category');
      batch.execute('DROP TABLE IF EXISTS Project');
      batch.execute('DROP TABLE IF EXISTS Task');
      batch.execute('DROP TABLE IF EXISTS Step');
      this._createTables(batch);
    }

    if (oldVersion < 3) {
      this._updateCode_3(batch);
    }

    // Commit this batch.
    batch.commit();
  }

  void _createTables(Batch batch) {
    // Create the category table.
    batch.execute('''
      CREATE TABLE Category(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        created TEXT NOT NULL
      )
    ''');

    // Create the project table.
    batch.execute('''
      CREATE TABLE Project(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        color TEXT NOT NULL,
        created TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES Category(id) ON DELETE CASCADE
      )
    ''');

    // Create the task table.
    batch.execute('''
      CREATE TABLE Task(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        done INTEGER NOT NULL,
        note TEXT,
        important INTEGER NOT NULL,
        created_date TEXT NOT NULL,
        due_date TEXT,
        project_id INTEGER NOT NULL,
        FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE
      )
    ''');

    // Create the step table.
    batch.execute('''
      CREATE TABLE Step(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        done INTEGER NOT NULL,
        task_id INTEGER NOT NULL,
        FOREIGN KEY (task_id) REFERENCES Task(id) ON DELETE CASCADE
      )
    ''');
  }

  void _updateCode_3(Batch batch) {
    batch.execute('''
      ALTER TABLE Project
      ADD COLUMN icon TEXT DEFAULT 'folder'
    ''');
  }
}
