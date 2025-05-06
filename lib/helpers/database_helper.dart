import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the database path
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tapping_quality.db');

    // Open the database and create tables if they don't exist
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nik VARCHAR(255) NOT NULL UNIQUE,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        jabatan TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
''');
    await db.execute('''
      CREATE TABLE assessment_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nik_penyadap VARCHAR(255) FOREIGN KEY REFERENCES users(nik),
        nik_mandor VARCHAR(255) FOREIGN KEY REFERENCES users(nik),
        nik_instruktur VARCHAR(255) FOREIGN KEY REFERENCES users(nik),
        kemandoran TEXT,
        sub_divisi TEXT,
        blok VARCHAR(255) NOT NULL,
        task VARCHAR(255) NOT NULL,
        no_hancak VARCHAR(255) NOT NULL,
        tahun_tanam INTEGER NOT NULL,
        clone VARCHAR(255) NOT NULL,
        sistem_sadap TEXT NOT NULL,
        panel_sadap TEXT NOT NULL,
        jenis_sadap TEXT NOT NULL,
        tanggal_inspeksi DATETIME NOT NULL,
      )
    ''');

    await db.execute('''
      CREATE TABLE foreman_assesments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parameter TEXT NOT NULL,
      syarat TEXT NOT NULL,
      skor INTEGER NOT NULL,
      p1 BOOLEAN NOT NULL,
      p2 BOOLEAN NOT NULL,
      p3 BOOLEAN NOT NULL,
      p4 BOOLEAN NOT NULL,
      p5 BOOLEAN NOT NULL,
      p6 BOOLEAN NOT NULL,
      p7 BOOLEAN NOT NULL,
      p8 BOOLEAN NOT NULL,
      p9 BOOLEAN NOT NULL,
      p10 BOOLEAN NOT NULL,
      )
''');

    await db.execute('''
      CREATE TABLE instructor_assesments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      parameter TEXT NOT NULL,
      syarat TEXT NOT NULL,
      skor INTEGER NOT NULL,
      p1 BOOLEAN NOT NULL,
      p2 BOOLEAN NOT NULL,
      p3 BOOLEAN NOT NULL,
      p4 BOOLEAN NOT NULL,
      p5 BOOLEAN NOT NULL,
      p6 BOOLEAN NOT NULL,
      p7 BOOLEAN NOT NULL,
      p8 BOOLEAN NOT NULL,
      p9 BOOLEAN NOT NULL,
      p10 BOOLEAN NOT NULL,
      verified_by VARCHAR(255),
      verified_at DATETIME,
      )
''');
  }
}
