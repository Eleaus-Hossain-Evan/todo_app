import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/home_controller.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/views/todo_deatil/todo_detail_page.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;

  const TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: controller.colorList[todo.color],
        ),
        child: InkWell(
          onTap: () => Get.to(
            () => TodoDetailPage(
              todo: todo,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          DateFormat('MMM d, h:mm a').format(todo.createdAt),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 13, color: Colors.grey[100]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60.h,
                child: VerticalDivider(
                  thickness: 2.w,
                  color: todo.isCompleted ? Colors.greenAccent : Colors.grey,
                ),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  todo.isCompleted ? "COMPLETED" : "TODO",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
