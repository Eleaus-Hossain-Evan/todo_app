import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/views/theme/theme.dart';

import '../widgets/k_textfield.dart';

class TodoDetailPage extends StatelessWidget {
  TodoDetailPage({Key? key, required this.todo}) : super(key: key);

  final TodoModel todo;

  final titleController = TextEditingController();

  var isEditable = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        titleController.text = todo.title;
        // controller.isCompleted(todo.isCompleted);
        return Scaffold(
          // backgroundColor: controller.colorList[todo.color],
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    DateFormat('EEEE - MMMM d, y,\n h:mm a')
                        .format(todo.createdAt),
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: controller.colorList[todo.color],
                    ),
                    child: Obx(() => KTextField(
                          controller: titleController,
                          isEnable: isEditable.value,
                          text: todo.title,
                          isHintText: true,
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () => Align(
                      alignment: const Alignment(0, 0),
                      child: isEditable.value
                          ? InputChip(
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 20.w),
                              label: Text(
                                controller.isCompleted.value
                                    ? todo.isCompleted
                                        ? "Completed"
                                        : "Incomplete"
                                    : "Incomplete",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              backgroundColor: Colors.grey.shade200,
                              elevation: 6,
                              shadowColor: Colors.grey[60],
                              padding: const EdgeInsets.all(8.0),
                              selected: controller.isCompleted.value,
                              selectedColor: KTheme.secondaryColor,
                              onSelected: (bool selected) {
                                controller.isCompleted.value = selected;
                              },
                            )
                          : Chip(
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 20.w),
                              label: Text(
                                todo.isCompleted ? "Completed" : "Incomplete",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.grey[60],
                              padding: const EdgeInsets.all(8.0),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isEditable(true);
                    },
                    child: const Text("Edit"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
