import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/helper_model.dart';

class DbHelper {
  
  static final DbHelper instance = DbHelper._init();

  static Database? _db;

  DbHelper._init();

  //late Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db!;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTrade = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTrade;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products (id integer primary key, baslik text, aciklama text )");
  }

  Future<List<Note>> getProducts() async {
    Database db = await this.db;

    var response = await db.query("products");

    return List.generate(
        response.length, (index) => Note.fromJson(response[index]));
  }

  Future<int> insert(Note product) async {
    Database db = await this.db;

    var response = await db.insert("products", product.toJson());
    return response;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;

    var response = await db.rawDelete("Delete from products where id=$id");
    return response;
  }
    Future close() async {
    final _db = await instance.db;

    _db.close();
  }

    Future<List<Note>> readAllNotes() async {
    final _db = await instance.db;

    final orderBy = 'id ASC';
    final result =
         await _db.rawQuery('SELECT * FROM products ORDER BY $orderBy');

    //final result = await db.query("products", orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note product) async {
    Database db = await this.db;

    var response = await db.update("products", product.toJson(),
        where: "id=?", whereArgs: [Product.id]);
    return response;
  }

    Future<Note> create(Note note) async {
    final db = await instance.db;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }
  
}