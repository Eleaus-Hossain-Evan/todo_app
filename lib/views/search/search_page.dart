import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/views/widgets/k_textfield.dart';

import '../../model/todo_model.dart';
import '../home/widgets/todo_tile.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final textController = TextEditingController();
  final RxList<TodoModel> filteredTodo = <TodoModel>[].obs;

  @override
  Widget build(BuildContext context) {
    void filterList(String value) {
      filteredTodo.assignAll(filteredTodo
          .where((p0) => p0.title.toLowerCase().contains(value.toLowerCase()))
          .toList());
      filteredTodo.refresh();
    }

    return GetBuilder<HomeController>(
      builder: (controller) {
        filteredTodo.assignAll(controller.todoList);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.black87,
            title: const Text("Search Todo"),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: "Write here to search",
                  ),
                  onChanged: (text) {
                    filterList(text);
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredTodo.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    var todo = filteredTodo[index];
                    return TodoTile(todo: todo);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
