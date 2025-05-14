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
        jabatan TEXT DEFAULT NULL,
        status TEXT DEFAULT NULL,
        departemen TEXT NOT NULL,
        kemandoran TEXT DEFAULT NULL,
        email TEXT DEFAULT NULL,
        password TEXT DEFAULT NULL,
        no_hp TEXT DEFAULT NULL
      );
''');
    await db.execute('''
      CREATE TABLE assessment_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        assessment_code VARCHAR(75) NOT NULL,
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
        'jenis_kulit_pohon' TEXT NOT NULL,
        tanggal_inspeksi DATETIME NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        nik_mandor VARCHAR(255),
        nik_instruktur VARCHAR(255),
        nik_penyadap VARCHAR(255),
        verified_at DATETIME DEFAULT NULL,
        foreman_upload_at DATETIME DEFAULT NULL,
        instructor_upload_at DATETIME DEFAULT NULL,
        FOREIGN KEY (nik_penyadap) REFERENCES users(nik)
      );
    ''');

    await db.execute('''
      CREATE TABLE criteria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT DEFAULT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
''');

    await db.execute('''
      CREATE TABLE trees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tree_identifier VARCHAR(255) NOT NULL
        )
    ''');

    await db.execute('''
     CREATE TABLE tree_assessments (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     assessment_detail_id INTEGER NOT NULL,
     tree_id INTEGER NOT NULL,
     criteria_id INTEGER NOT NULL
     )
''');

    await db.execute('''
      INSERT INTO users (nik, name, role, jabatan, status, departemen, kemandoran, email, password, no_hp)
      VALUES
      ('111-111', 'Arif Halimawan', 'Mandor', 'Mdr', 'Monthly', 'Sub Divisi A', NULL, NULL, NULL, NULL),
        ('222-222', 'John Doe', 'Instruktur', 'Inst', 'Monthly', 'Sub Divisi A', NULL, NULL, NULL, NULL),
        ('333-333', 'Krisna Mukti Wibowo', 'Penyadap', '', 'FL', 'Sub Divisi A', 'Arif Halimawan', NULL, NULL, NULL),
        ('444-444', 'M. Novriyan', 'Penyadap', '', 'Reguler', 'Sub Divisi A', 'Arif Halimawan', NULL, NULL, NULL),
        ('555-555', 'M. Hidayaturrahman', 'Penyadap', '', 'Reguler', 'Sub Divisi A', 'Arif Halimawan', NULL, NULL, NULL),
        ('666-666', 'Nanda Dwi Perkasa', 'Penyadap', '', 'Reguler', 'Sub Divisi A', 'Arif Halimawan', NULL, NULL, NULL),
        ('777-777', 'Alif Ilham', 'Penyadap', '', 'FL', 'Sub Divisi A', NULL, NULL, 'Arif Halimawan', NULL)
''');
  }

  Future<void> checkTables() async {
    final db = await database;

    // Query the sqlite_master table to get the list of tables
    final tables = await db.rawQuery(
      "SELECT * FROM sqlite_master WHERE type='table'",
    );
    print('Tables in the database: $tables');
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tapping_quality.db');

    await deleteDatabase(path);
    print('Database deleted successfully');
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;

    // Query the users table
    final result = await db.query('users');
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllAssessmentDetails() async {
    final db = await database;

    // Query the assessment_details table
    final result = await db.query('assessment_details');
    return result;
  }
}
