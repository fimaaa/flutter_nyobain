import 'dart:convert';

import 'package:flutter_application_1/Penilaian.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "penilaiandb.db";
  static const _databaseVersion = 1;

  static const table = 'penilaian_table';

  static const columnId = 'id';
  static const columnDateNow = 'dateNow';
  static const columnName = 'name';
  static const columnJabatan = 'jabatan';
  static const columnLokasi = 'lokasi';
  static const columnKeterangan = 'keterangan';
  static const columnListPenilaian = 'listPenilaian';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  // static Database _database;
  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //   // lazily instantiate the db the first time it is accessed
  //   _database = await _initDatabase();
  //   return _database;
  // }
  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initiateDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnDateNow DATETIME NOT NULL,
            $columnJabatan TEXT NOT NULL,
            $columnLokasi TEXT NOT NULL,
            $columnKeterangan TEXT NOT NULL,
            $columnListPenilaian TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Penilaian penilaian) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'name': penilaian.name,
      'dateNow': penilaian.dateNow.toString(),
      'jabatan': penilaian.jabatan,
      'lokasi': penilaian.lokasi,
      'keterangan': penilaian.keterangan,
      'listPenilaian': Penilaian.listPenelitianToString(penilaian.listPenilaian)
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRowsName(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$name%'");
  }

  Future<List<Map<String, dynamic>>> queryRow(id) async {
    Database db = await instance.database;
    String whereString = '${DatabaseHelper.columnId} = ?';
    List<dynamic> whereArguments = [id];
    return await db.query(DatabaseHelper.table,
        where: whereString, whereArgs: whereArguments);
    // return await db.query(table, where: "$columnId = '%$id%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $table')) ??
        0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Penilaian penilaian) async {
    Database db = await instance.database;
    int id = penilaian.toMap()['id'];
    return await db.update(table, penilaian.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
