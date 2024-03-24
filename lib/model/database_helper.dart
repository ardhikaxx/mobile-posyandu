import 'package:path/path.dart';
import 'package:posyandu/model/user.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  final String dbName = 'posyandu.db';
  final String tableName = 'users';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            nikIbu TEXT,
            namaIbu TEXT,
            gender TEXT,
            placeOfBirth TEXT,
            birthDate TEXT,
            alamat TEXT,
            telepon TEXT,
            password TEXT
          )''',
        );
      },
    );
  }

  Future<int> insertData(User user) async {
    final db = await _openDatabase();
    return await db.insert(tableName, user.toMap());
  }

  Future<bool> login(User users) async {
    final db = await _openDatabase();
    var result = await db.query(tableName,
        where: 'email = ? AND password = ?',
        whereArgs: [users.email, users.password]);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await _openDatabase();
    var result = await db.query(tableName,
        where: 'email = ?',
        whereArgs: [email]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<User> getUserData() async {
    final db = await _openDatabase();
    final List<Map<String, dynamic>> result = await db.query(tableName);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      throw Exception("No user data found");
    }
  }
}
