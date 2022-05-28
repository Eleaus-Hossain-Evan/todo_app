import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class KTextField extends StatefulWidget {
  KTextField({
    Key? key,
    required this.controller,
    required this.text,
    this.onChanged,
    this.isDate = false,
    this.isTime = false,
    this.isObscure = false,
    this.isHintText = false,
    this.isEnable = true,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius = 10,
    this.width = 280,
    this.textColor = Colors.white,
  }) : super(key: key);
  final TextEditingController controller;
  final String text;
  Color textColor;
  Function(String value)? onChanged;
  bool isDate, isTime, isObscure, isHintText, isEnable;
  Widget? suffixIcon, prefixIcon;
  double borderRadius, width = 280.w;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      // height: 50.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: TextField(
          controller: widget.controller,
          readOnly: !widget.isEnable,
          textAlign: TextAlign.start,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          minLines: null,
          maxLines: null,
          // expands: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 8.w,
              top: 3.h,
              bottom: 3.h,
            ),
            isDense: false,
            border: UnderlineInputBorder(
              //borderSide: BorderSide(color: Colors.black26, width: 3.w),
              borderSide: BorderSide(
                color: widget.isEnable ? Colors.white70 : Colors.transparent,
                width: 3.w,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.isEnable ? Colors.white70 : Colors.transparent,
                  width: 3.w,
                ),
                //borderSide: BorderSide(color: Colors.black26, width: 3.w),
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isEnable ? Colors.white70 : Colors.transparent,
                  width: 3.w),
              // borderSide:
              //     BorderSide(color: KColor.customerPrimaryColor, width: 2.w),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            labelText: widget.isHintText ? null : widget.text,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Colors.black87,
            ),
            hintText: widget.isHintText ? widget.text : null,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              //color: Colors.black87,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon != null
                ? widget.suffixIcon
                : widget.isObscure
                    ? InkWell(
                        onTap: () => setState(() {
                          isVisible = !isVisible;
                        }),
                        child: const Icon(Icons.remove_red_eye_rounded),
                      )
                    : null,
          ),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18.sp,
            color: widget.textColor,
          ),
          obscureText: widget.isObscure ? isVisible : false,
          onChanged: widget.onChanged,
          onTap: () {
            if (widget.isDate) {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 2),
                currentDate: DateTime.now(),
                helpText: 'Select a date',
              ).then((value) {
                widget.controller.text =
                    DateFormat('MMMM dd, yyyy').format(value!);
              });
            }
            if (widget.isTime) {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                helpText: 'Select a date',
              ).then((value) {
                var now = DateTime.now();
                if (value != null) {
                  widget.controller.text =
                      DateFormat('hh:mm aa').format(DateTime(
                    now.year,
                    now.month,
                    now.day,
                    value.hour,
                    value.minute,
                  ));
                }
              });
            }
          },
        ),
      ),
    );
  }
}
