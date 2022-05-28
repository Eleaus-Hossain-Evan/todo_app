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
          // PopupMenuButton<int>(
          //   child: IconButton(
          //       onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
          //     const PopupMenuItem<int>(
          //       value: 0,
          //       child: Text("Sort by ID ASC"),
          //     ),
          //     const PopupMenuItem<int>(
          //       value: 1,
          //       child: Text("Sort by ID DES"),
          //     ),
          //     const PopupMenuItem<int>(
          //       value: 2,
          //       child: Text("Sort by Date ASC"),
          //     ),
          //     const PopupMenuItem<int>(
          //       value: 3,
          //       child: Text("Sort by Date DES"),
          //     )
          //   ],
          //   onSelected: (int value) {
          //     print(value);
          //   },
          // )
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 0,
                child: Text("Sort by ID ASC"),
                onTap: () {},
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Sort by ID DES"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Sort by Date ASC"),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text("Sort by Date DES"),
              )
            ],
            onSelected: (int value) {
              switch (value) {
                case 0:
                  controller.sortByID();
                  break;
                case 1:
                  controller.sortByIdDes();
                  break;
                case 2:
                  controller.sortByDate();
                  break;
                case 3:
                  controller.sortByDateDes();
                  break;
                default:
              }
            },
          )
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
