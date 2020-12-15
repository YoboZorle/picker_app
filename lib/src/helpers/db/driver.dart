import 'dart:io';
import 'package:path/path.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String databaseName = "yarner.driver.db";
final String tableDriver = 'driver';
final String columnId = '_userId';
final String columnPlateNumber = 'plateNumber';
final String columnTicketNumber = 'ticketNumber';
final String columnCompanyName = 'companyName';
final String columnStatus = 'status';
final String columnBlocked = 'blocked';
final String columnIsDelivering = 'isDelivering';
final String columnCreatedAt = 'createdAt';
final String columnTotalRides = 'totalRides';
final String columnOngoingRides = 'ongoingRides';
final String columnCompletedRides = 'completedRides';

class DriverProvider {
  Database db;

  DriverProvider._privateConstructor();

  static final DriverProvider instance = DriverProvider._privateConstructor();

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
create table $tableDriver ( 
  $columnId integer primary key autoincrement, 
  $columnPlateNumber text,
  $columnTicketNumber text,
  $columnCompanyName text,
  $columnStatus text,
  $columnIsDelivering integer,
  $columnCreatedAt text,
  $columnBlocked integer,
  $columnTotalRides integer,
  $columnOngoingRides integer,
  $columnCompletedRides integer)
''');
        });
  }

  Future<void> insert(Driver driver) async {
    await _initDatabase();
    await db.insert(tableDriver, driver.toMap());
  }

  Future<void> updateOrInsert(Driver driver) async {
    var result = await getDriver(driver.id);
    if (result != null) {
      await update(driver);
    }
    if (result == null) {
      await insert(driver);
    }
  }

  Future<Driver> getDriver(int id) async {
    await _initDatabase();
    List<Map> maps =
    await db.query(tableDriver, where: '$columnId = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Driver.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    await _initDatabase();
    return await db.delete(tableDriver, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Driver driver) async {
    await _initDatabase();
    return await db.update(tableDriver, driver.toMap(),
        where: '$columnId = ?', whereArgs: [driver.id]);
  }

  Future close() async {
    await _initDatabase();
    await db.close();
  }
}
