import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

import 'package:posyandu/model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static late Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    sqflite_ffi.sqfliteFfiInit(); // Initialize sqflite_common_ffi

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'posyandu_database.db');

    // Open the database manually
    var db = await databaseFactoryFfi.openDatabase(path);
    await _onCreate(db, 1); // Manually manage the version
    return db;
  }

  Future<void> _onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE User (
        id INTEGER PRIMARY KEY,
        email TEXT,
        nikIbu TEXT,
        namaIbu TEXT,
        gender TEXT,
        placeOfBirth TEXT,
        birthDate TEXT,
        alamat TEXT,
        telepon TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toJson());
    return res;
  }

  Future<User?> loginUser(String email, String password) async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query("User",
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    }
    return null;
  }

  Future<List<User>> getAllUsers() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query("User");
    List<User> users = [];
    for (Map<String, dynamic> item in result) {
      users.add(User.fromJson(item));
    }
    return users;
  }
}