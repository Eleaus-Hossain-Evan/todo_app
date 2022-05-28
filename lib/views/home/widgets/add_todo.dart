import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/views/theme/theme.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key}) : super(key: key);

  final todoEditingController = TextEditingController();

  // late StreamController<bool> _completeBoxController;
  // late StreamController<bool> _doneBoxController;
  // Stream<bool> get _completeBoxStream => _completeBoxController.stream;
  // Stream<bool> get _doneBoxStream => _completeBoxController.stream;

  // @override
  // void initState() {
  //   _completeBoxController = StreamController();
  //   _doneBoxController = StreamController();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _completeBoxController.close();
  //   _doneBoxController.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var colorIndex = 0.obs;
    return GetBuilder<HomeController>(
      builder: (controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add New Todo",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                    ),
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) => states.contains(MaterialState.pressed)
                          ? KTheme.secondaryColor
                          : null,
                    ),
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close_fullscreen_outlined),
                  ),
                ],
              ),
              content: IntrinsicHeight(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: TextField(
                        controller: todoEditingController,
                        decoration: const InputDecoration(
                          hintText: "Enter Todo",
                        ),
                        autofocus: true,
                      ),
                    ),
                    InputChip(
                      padding: EdgeInsets.all(10.w),
                      elevation: controller.isCompleted.value ? 8 : 0,
                      label: Text(
                        'Is Complete',
                        style: TextStyle(
                          color: controller.isCompleted.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      selected: controller.isCompleted.value,
                      selectedColor: KTheme.secondaryColor,
                      onSelected: (bool selected) {
                        setState(() {
                          controller.isCompleted.value = selected;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          controller.colorList.length,
                          (index) => InkWell(
                            onTap: () => colorIndex.value = index,
                            child: CircleAvatar(
                              backgroundColor: controller.colorList[index],
                              child: index == colorIndex.value
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null,
                              radius: 18.r,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: ElevatedButton(
                    onPressed: () {
                      if (todoEditingController.text.isNotEmpty) {
                        controller.insertTodo(
                          todoEditingController.text,
                          controller.isCompleted.value,
                          colorIndex.value,
                        );
                        todoEditingController.clear();
                        controller.isCompleted(false);
                        Get.back();
                      }
                    },
                    child: controller.loading.isTrue
                        ? const CircularProgressIndicator()
                        : const Text("Add Todo"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => states.contains(MaterialState.pressed)
                            ? KTheme.secondaryColor
                            : KTheme.primaryColor,
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size.fromHeight(40.h),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
