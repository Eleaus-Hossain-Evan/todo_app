import 'dart:async';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo_model.dart';

class DbController extends GetxController {
  static Database? _database;

  static const int _version = 1;
  static const _databaseName = "TodoDatabase.db";
  static const String _tableName = "todo";

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
      "CREATE TABLE $_tableName("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "todo TEXT, "
      "startTime STRING, "
      "isCompleted INTEGER)",
    );
  }

  Future close() async {
    Database db = await database;
    db.close();
  }

  Future<List<TodoModel>?> getAll() async {
    Logger().v("getting all todo's");
    var items = await _database!.query(_tableName, orderBy: 'id');
    List<TodoModel> itemList =
        items.isNotEmpty ? items.map((e) => TodoModel.fromMap(e)).toList() : [];
    close();
    return itemList;
  }

  static Future<int> insert(TodoModel? todo) async {
    Logger().v("insert $todo");
    return await _database?.insert(_tableName, todo!.toMap()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    Logger().v("query function called");
    return await _database!.query(_tableName);
  }

  static delete(TodoModel todo) async {
    Logger().v("delete $todo");
    return await _database!
        .delete(_tableName, where: 'id=?', whereArgs: [todo.id]);
  }

  static updateComplete(int id, int completed) async {
    Logger().v("update single todo: $id");
    return await _database!.rawUpdate('''
      UPDATE todo
      SET isCompleted = ?
      WHERE id =?
    ''', [completed.toString(), id]);
  }

  Future<int> updateData(TodoModel todo) async {
    Logger().v("update $todo");
    return await _database!
        .update(_tableName, todo.toMap(), where: "id=?", whereArgs: [todo.id]);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
