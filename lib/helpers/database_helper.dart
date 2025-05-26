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

    // users
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
    // assessment_details
    await db.execute('''
      CREATE TABLE assessment_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        assessment_code VARCHAR(75) NOT NULL,
        nik_penyadap VARCHAR(255) CONSTRAINT fk_nik_penyadap REFERENCES users(nik),
        blok VARCHAR(255) NOT NULL,
        task VARCHAR(255) NOT NULL,
        no_hancak VARCHAR(255) NOT NULL,
        tahun_tanam INTEGER NOT NULL,
        clone VARCHAR(255) NOT NULL,
        sistem_sadap TEXT NOT NULL,
        panel_sadap TEXT NOT NULL,
        jenis_sadap TEXT NOT NULL,
        jenis_kulit_pohon TEXT NOT NULL,
        tanggal_inspeksi DATE NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        foreman_upload_at DATETIME DEFAULT NULL
      );
    ''');

    // criteria
    await db.execute('''
      CREATE TABLE criteria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT DEFAULT NULL,
        score DOUBLE DEFAULT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
''');

    // trees
    await db.execute('''
      CREATE TABLE trees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tree_identifier VARCHAR(255) NOT NULL
        )
    ''');

    // tree_assessments
    await db.execute('''
     CREATE TABLE tree_assessments (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     assessment_detail_id INTEGER NOT NULL,
     tree_id INTEGER NOT NULL,
     criteria_id INTEGER NOT NULL
     )
''');

    // Create users
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
    // Create criteria
    await db.execute('''
INSERT INTO criteria (id, name, description, score) VALUES
(1, 'Luka kayu', 'Kecil (1 cm x 0.6 cm)', 3),
(2, 'Luka kayu', 'Sedang (1.5 cm x 3 cm)', 5),
(3, 'Luka kayu', 'Besar (>1.5 cm x 3 cm)', 7),
(4, 'Luka kayu', 'Tidak ada luka kayu', 0),
(5, 'Teknik Penyadapan Panel Atas', 'Tidak menggunakan gagang pisau panjang', 3),
(6, 'Teknik Penyadapan Panel Atas', 'Tidak menggunakan pisau sodhok (HO)', 5),
(7, 'Teknik Penyadapan Panel Atas', 'Sadapan tidak dishodok/ditarik', 7),
(8, 'Teknik Penyadapan Panel Atas', 'Teknik Penyadapan Panel Atas Sudah sesuai', 0),
(9, 'Kedalaman Sadap', 'Kurang Dalam', 2),
(10, 'Kedalaman Sadap', 'Normatif', 0),
(11, 'Kedalaman Sadap', 'Terlalu Dalam', 4),
(12, 'Irisan Sadap','Irisan melampauai batas depan', 2),
(13, 'Irisan Sadap','Irisan melampaui batas belakang', 2),
(14, 'Irisan Sadap', 'Tidak ada sodokan', 4),
(15, 'Irisan Sadap', 'Tidak ada pethikan (V)', 4),
(16, 'Irisan Sadap', 'Tebal tatal > 2mm', 10),
(17, 'Irisan Sadap', 'Bergelombang', 2),
(18, 'Irisan Sadap', 'Tidak ada Tanda Bulan', 2),
(19, 'Irisan Sadap', 'Irisan Sadap sudah sesuai', 0),
(20, 'Sudut Sadap', '> 30 derajat', 3),
(21, 'Sudut Sadap', '< 30 derajat', 3),
(22, 'Sudut Sadap', '30 derajat', 0),
(23, 'Sudut Sadap', '> 45 derajat', 3),
(24, 'Sudut Sadap', '< 45 derajat', 3),
(25, 'Sudut Sadap', '45 derajat', 0),
(26, 'Pengambilan Scrap', 'Diambil', 0),
(27, 'Pengambilan Scrap', 'Tidak diambil', 2),
(28, 'Peralatan tidak lengkap', 'Talang', 2),
(29, 'Peralatan tidak lengkap', 'Mangkok', 3),
(30, 'Peralatan tidak lengkap', 'Hanger', 1),
(31, 'Peralatan Tidak Lengkap', 'Peralatan Lengkap', 0),
(32, 'Kebersihan Alat', 'Talang Kotor', 1),
(33, 'Kebersihan Alat', 'Mangkok Kotor', 1),
(34, 'Kebersihan Alat', 'Alat Bersih', 0),
(35, 'Kebersihan Ember/Blong Latek', 'Bersih', 0),
(36, 'Kebersihan Ember/Blong Latek', 'Kotor', 2),
(37, 'Pohon Sehat tidak disadap', 'Ya', 10),
(38, 'Pohon Sehat tidak disadap', 'Tidak', 0),
(39, 'Hasil tidak dipungut', 'Ya', 10),
(40, 'Hasil tidak dipungut', 'Tidak', 0),
(41, 'Talang sadap mepet', 'Ya', 1),
(42, 'Talang sadap mepet', 'Tidak', 0);
      
      




''');
    // Create trees
    await db.execute('''
      INSERT INTO trees (tree_identifier) VALUES
      ('Pohon 1'),
      ('Pohon 2'),
      ('Pohon 3'),
      ('Pohon 4'),
      ('Pohon 5'),
      ('Pohon 6'),
      ('Pohon 7'),
      ('Pohon 8'),
      ('Pohon 9'),
      ('Pohon 10')
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
