import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE userdata(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        email TEXT,
        password TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Mechstore.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createUser(
      String username, String? email, String? password) async {
    final db = await DatabaseHelper.db();
    final data = {'username': username, 'email': email, 'password': password};
    final id = await db.insert('userdata', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<String> compareUser(String username, String password) async {
    final db = await DatabaseHelper.db();
    var res = await db.rawQuery(
        "SELECT * FROM userdata WHERE username = '$username' and password = '$password'");
    if (res.length > 0) {
      return "1";
    }
    return "0";
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await DatabaseHelper.db();
    return db.query('userdata', orderBy: "id");
  }




  static Future<int> updateUser(
      int id, String username, String? email, String? password) async {
    final db = await DatabaseHelper.db();
    final data = {
      'title': username,
      'email': email,
      'password': password,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('userdata', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteUser(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("userdata", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
