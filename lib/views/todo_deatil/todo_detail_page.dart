import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/views/theme/theme.dart';

import '../widgets/k_elevated_button.dart';
import '../widgets/k_textfield.dart';

class TodoDetailPage extends StatelessWidget {
  TodoDetailPage({Key? key, required this.todo}) : super(key: key);

  final TodoModel todo;

  final titleController = TextEditingController();

  var isEditable = false.obs;
  var isCompleteForThis = false.obs;
  var colorIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    Logger().wtf(todo);
    return GetBuilder<HomeController>(
      builder: (controller) {
        titleController.text = todo.title;
        controller.isCompleted(todo.isCompleted);
        colorIndex(todo.color);
        return Scaffold(
          // backgroundColor: controller.colorList[todo.color],
          appBar: AppBar(
            foregroundColor: Colors.black87,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    controller.deleteTodo(todo);
                    Get.back();
                  },
                  icon: const Icon(Icons.delete_forever))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    child: Obx(() => isEditable.value
                        ? KTextField(
                            controller: titleController,
                            isEnable: isEditable.value,
                            text: todo.title,
                            isHintText: true,
                          )
                        : Text(
                            todo.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          )),
                  ),
                  SizedBox(
                    height: 20.h,
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
                                    ? "Completed"
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
                              selected: isCompleteForThis.value,
                              selectedColor: KTheme.secondaryColor,
                              onSelected: (bool selected) {
                                isCompleteForThis.value = selected;
                                controller
                                    .isCompleted(!controller.isCompleted.value);
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
                              side: BorderSide(
                                color: todo.isCompleted
                                    ? KTheme.primaryColor
                                    : KTheme.secondaryColor,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => isEditable.value
                        ? SizedBox(
                            height: 40.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.colorList.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(width: 5.w);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Obx(() => InkWell(
                                      onTap: () => colorIndex.value = index,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            controller.colorList[index],
                                        child: colorIndex.value == index
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              )
                                            : const SizedBox.shrink(),
                                        radius: 18.r,
                                      ),
                                    ));
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => !isEditable.value
                        ? KElevatedButton(
                            onPressed: () {
                              isEditable(true);
                            },
                            child: const Text("Edit"),
                          )
                        : KOutlinedButton(
                            onPressed: () {
                              controller.updateData(
                                TodoModel(
                                  id: todo.id,
                                  title: titleController.text,
                                  createdAt: DateTime.now(),
                                  isCompleted: controller.isCompleted.value,
                                  color: colorIndex.value,
                                ),
                              );
                              Get.back();
                            },
                            child: const Text("Update Todo"),
                          ),
                  ),
                  Obx(() => isEditable.value
                      ? KElevatedButton(
                          onPressed: () {
                            // Get.back();
                            isEditable(false);
                          },
                          child: const Text("Cancel"),
                          primaryColor: Colors.orangeAccent.shade400,
                          secondaryColor: Colors.redAccent.shade100,
                        )
                      : const SizedBox.shrink()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
