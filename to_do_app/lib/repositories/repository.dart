import 'package:sqflite/sqlite_api.dart';
import 'package:to_do_app/repositories/db_connections.dart';

class Repository {
  DataBaseConection? _dataBaseConnection;
  Repository() {
    _dataBaseConnection = DataBaseConection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database ?? await _dataBaseConnection?.setDatabase()) ;
    return _database;
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query("categories");
  }
  
  readDataById(table,itemId) async {
    var connection = await database;
    return await connection?.query(table , where: "id=?",whereArgs: [itemId]);
  }
  updateCategory(table,data) async {
    var connection = await database;
    return await connection?.update(table ,data, where: "id=?",whereArgs: [data["id"]]);
  }




}
