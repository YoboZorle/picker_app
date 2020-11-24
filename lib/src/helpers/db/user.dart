import 'dart:io';
import 'package:path/path.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String databaseName = "yarner.user.db";
final String tableUser = 'user';
final String columnId = '_userId';
final String columnFirstname = 'firstname';
final String columnLastname = 'lastname';
final String columnPhone = 'phone';
final String columnEmail = 'email';
final String columnProfileImageUrl = 'profileImageUrl';
final String columnCallingCode = 'callingCode';
final String columnOnlineStatus = 'onlineStatus';

class UserProvider {
  Database db;

  UserProvider._privateConstructor();

  static final UserProvider instance = UserProvider._privateConstructor();

  _initDatabase() async {
    if (db != null) return;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    await open(path);
  }

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableUser ( 
  $columnId integer primary key autoincrement, 
  $columnFirstname text not null,
  $columnLastname text not null,
  $columnProfileImageUrl text not null,
  $columnPhone text not null,
  $columnEmail text not null,
  $columnCallingCode text not null,
  $columnOnlineStatus integer not null)
''');
    });
  }

  Future<void> insert(User user) async {
    await _initDatabase();
    await db.insert(tableUser, user.toMap());
  }

  Future<void> updateOrInsert(User user) async {
    var result = await getUser(user.id);
    if (result != null) {
      await update(user);
    }
    if (result == null) {
      await insert(user);
    }
  }

  Future<User> getUser(int id) async {
    await _initDatabase();
    List<Map> maps =
        await db.query(tableUser, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    await _initDatabase();
    return await db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    await _initDatabase();
    return await db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() async {
    await _initDatabase();
    await db.close();
  }
}
