import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/controller/database_helper_controller.dart';
import 'package:todo_app/model/todo_model.dart';

class HomeController extends GetxController {
  final loading = false.obs;
  final RxList<TodoModel> todoList = <TodoModel>[].obs;
  final RxList<TodoModel> filteredTodo = <TodoModel>[].obs;

  final colorList = const [
    Color(0xFF4e5ae8),
    Color(0xFFff4667),
    Color(0xFFFFB746),
    Color(0xFF7E57C2),
    Color(0xFF66BB6A),
  ];

  var isCompleted = false.obs;

  var isDone = false.obs;

  DbController? db;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    db = DbController.instance();
    await getAllTodos();
  }

  Future<void> getAllTodos() async {
    loading(true);
    var list = await db!.getAll();
    Logger().wtf(list);

    list!.isNotEmpty ? todoList.assignAll(list) : null;
    todoList.refresh;
    Logger().i(todoList);
    loading(false);
    update();
  }

  void insertTodo(String text, bool isCompleted, int color) async {
    loading(true);
    var todo = TodoModel(
      title: text,
      isCompleted: isCompleted,
      createdAt: DateTime.now(),
      color: color,
    );
    int id = await db!.insert(todo);
    Logger().wtf("Successfully inserted todo: $id");
    await getAllTodos();
    loading(false);
    update();
  }

  void updateData(TodoModel todoModel) async {
    loading(true);

    int id = await db!.updateData(todoModel);
    Logger().wtf("Successfully updated todo: $id");
    await getAllTodos();
    loading(false);
    update();
  }

  void updateCompleted(int todoId, bool completed) async {
    loading(true);

    int id = await db!.updateComplete(todoId, completed ? 1 : 0);
    Logger().wtf("Successfully updated todo: $id");
    await getAllTodos();
    loading(false);
    update();
  }

  void deleteTodo(TodoModel todoModel) async {
    loading(true);

    int id = await db!.delete(todoModel);
    Logger().wtf("Successfully updated todo: $id");
    await getAllTodos();
    loading(false);
    update();
  }

  void filterList(value) {
    filteredTodo(todoList
        .where((todo) => todo.title.toLowerCase().contains(value.toLowerCase()))
        .toList());
    filteredTodo.refresh();
    update();
  }

  void sortByID() {
    todoList.sort((a, b) => a.id!.compareTo(b.id!));
  }

  void sortByDate() {
    todoList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  void sortByIdDes() {
    todoList.sort((a, b) => b.id!.compareTo(a.id!));
  }

  void sortByDateDes() {
    todoList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
