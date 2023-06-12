import 'package:app_conference/models/conference.dart';
import 'package:app_conference/models/specialization.dart';
import 'package:app_conference/models/login.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'conference.db');
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {login} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE login(id INTEGER PRIMARY KEY, name TEXT, username TEXT, password TEXT)',
    );
    // Run the CREATE {conference_info} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE conference_info(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone INTEGER, role TEXT, specialize_areaId INTEGER, FOREIGN KEY (specialize_areaId) REFERENCES specialize_area(id) ON DELETE SET NULL)',
    );
    // Run the CREATE {specialize_area} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE specialize_area(id INTEGER PRIMARY KEY, area TEXT)',
    );
    // Run the CREATE {specialize_area(area)} TABLE statement on the database.
    await db.execute(
      'INSERT INTO specialize_area(area) VALUES ("Artificial Intelligence")',
    );
    await db.execute(
      'INSERT INTO specialize_area(area) VALUES ("Data Mining")',
    );
    await db.execute(
      'INSERT INTO specialize_area(area) VALUES ("Computer Security")',
    );
    await db.execute(
      'INSERT INTO specialize_area(area) VALUES ("Internet Of Things")',
    );
    await db.execute(
      'INSERT INTO specialize_area(area) VALUES ("Software Engineering")',
    );
  }

  Future<void> insertConferenceInfo(Conference conferenceInfo) async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    // Insert the ConferenceInfo into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same breed is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'conference_info',
      conferenceInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertlogin(Login login) async {
    final db = await _databaseService.database;
    await db.insert(
      'login',
      login.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Specialization>> Special_types() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('conference_info');
    return List.generate(
        maps.length, (index) => Specialization.fromMap(maps[index]));
  }

  Future<bool> checkUser(String username, String password) async {
    final db = await _databaseService.database;
    try {
      List<Map> users = await db.query('login',
          where: 'username = ? and password = ?',
          whereArgs: [username, password]);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<Specialization> specialize_area(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('specialize_area', where: 'id = ?', whereArgs: [id]);
    return Specialization.fromMap(maps[0]);
  }

  Future<List<Conference>> conferenceInfo() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('conference_info');
    return List.generate(
        maps.length, (index) => Conference.fromMap(maps[index]));
  }

//Specialize Area database
  Future<List<Login>> logins() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('login');
    return List.generate(maps.length, (index) => Login.fromMap(maps[index]));
  }

//Check user credential from database
  Future<Login> login(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('login', where: 'id = ?', whereArgs: [id]);
    return Login.fromMap(maps[0]);
  }

// Define a function that inserts conference_info into the database
  Future<void> deleteConferenceInfo(int id) async {
    final db = await _databaseService.database;
    await db.delete('conference_info', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateConferenceInfo(Conference ConferenceInfo) async {
    final db = await _databaseService.database;
    await db.update('conference_info', ConferenceInfo.toMap(),
        where: 'id = ?', whereArgs: [ConferenceInfo.id]);
  }
}
