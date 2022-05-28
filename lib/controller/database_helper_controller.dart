import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo_model.dart';

class DbController extends GetxController {
  static Database? _database;

  static const int _version = 1;
  static const _databaseName = "TodoDatabase.db";

  DbController._();

  static final DbController _instance = DbController._();
  factory DbController.instance() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String _path = await getDatabasesPath() + _databaseName;
    var initDatabase = await openDatabase(
      _path,
      version: _version,
      onCreate: _onCreate,
    );
    return initDatabase;
  }

  FutureOr<void> _onCreate(database, version) {
    Logger().v("creating a Database");
    return database.execute(
      "CREATE TABLE $tableTodo("
      "$columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
      "$columnTitle TEXT not null, "
      "$columnCreatedAt STRING not null, "
      "$columnIsCompleted INTEGER not null, "
      "$columnColor INTEGER not null)",
    );
  }

  Future close() async {
    Database db = await database;
    db.close();
  }

  Future<List<TodoModel>?> getAll() async {
    Logger().v("getting all todo's");
    var db = await database;
    List<Map<String, dynamic>> items =
        await db.query(tableTodo, orderBy: columnId);
    List<TodoModel> itemList =
        items.isNotEmpty ? items.map((e) => TodoModel.fromMap(e)).toList() : [];

    return itemList;
  }

  Future<int> insert(TodoModel todo) async {
    Logger().v("insert $todo");
    var db = await database;
    var result = await db.insert(tableTodo, todo.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> query() async {
    Logger().v("query function called");
    var db = await database;
    return await db.query(tableTodo);
  }

  Future<int> delete(TodoModel todo) async {
    Logger().v("delete $todo");
    var db = await database;
    var result =
        await db.delete(tableTodo, where: '$columnId=?', whereArgs: [todo.id]);

    return result;
  }

  Future<int> updateComplete(int id, int completed) async {
    Logger().v("update single todo: $id");
    var db = await database;
    var result = await db.rawUpdate('''
      UPDATE todo
      SET isCompleted = ?
      WHERE $columnId =?
    ''', [completed.toString(), id]);

    return result;
  }

  Future<int> updateData(TodoModel todo) async {
    Logger().v("update $todo");
    return await _database!.update(tableTodo, todo.toMap(),
        where: "$columnId=?", whereArgs: [todo.id]);
  }
}
