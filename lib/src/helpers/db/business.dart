import 'dart:io';
import 'package:path/path.dart';
import 'package:pickrr_app/src/models/business.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String databaseName = "logistics.business.db";
final String tableBusiness = 'business';
final String columnId = 'id';
final String columnName = 'name';
final String columnLogo = 'logo';
final String columnLocation = 'location';
final String columnEmail = 'email';
final String columnPhone = 'phone';
final String columnBlocked = 'blocked';
final String columnBalanceHumanized = 'balance_humanized';
final String columnBalance = 'balance';
final String columnDebt = 'total_debt';

class BusinessProvider {
  Database db;

  BusinessProvider._privateConstructor();

  static final BusinessProvider instance =
      BusinessProvider._privateConstructor();

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
create table $tableBusiness ( 
  $columnId integer primary key autoincrement, 
  $columnName text,
  $columnLogo text,
  $columnLocation text,
  $columnEmail text,
  $columnPhone text,
  $columnBalanceHumanized text,
  $columnBalance text,
  $columnDebt text,
  $columnBlocked integer)
''');
    });
  }

  Future<void> insert(Business business) async {
    await _initDatabase();
    await db.insert(tableBusiness, business.toMap());
  }

  Future<void> updateOrInsert(Business business) async {
    var result = await getBusiness(business.id);
    if (result != null) {
      await update(business);
    }
    if (result == null) {
      await insert(business);
    }
  }

  Future<Business> getBusiness(int id) async {
    await _initDatabase();
    List<Map> maps =
        await db.query(tableBusiness, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Business.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    await _initDatabase();
    return await db
        .delete(tableBusiness, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Business business) async {
    await _initDatabase();
    return await db.update(tableBusiness, business.toMap(),
        where: '$columnId = ?', whereArgs: [business.id]);
  }

  Future close() async {
    await _initDatabase();
    await db.close();
  }
}
