import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/views/home/widgets/add_todo.dart';
import 'package:todo_app/views/home/widgets/todo_tile.dart';
import 'package:todo_app/views/search/search_page.dart';
import 'package:todo_app/views/theme/theme.dart';
import 'package:todo_app/views/widgets/k_textfield.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var isLoading = controller.loading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text("Todo's"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Obx(
        () => ListView.separated(
          // shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.todoList.length,
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            var todo = controller.todoList[index];
            return TodoTile(todo: todo);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [Text("Add Todo"), Icon(Icons.add)],
        ),
        backgroundColor: KTheme.secondaryColor,
        elevation: 5,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodo(),
        ),
      ),
    );
  }
}
