import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

class KElevatedButton extends StatelessWidget {
  KElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.primaryColor = KTheme.primaryColor,
    this.secondaryColor = KTheme.secondaryColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  Color primaryColor;
  Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed)
              ? secondaryColor
              : primaryColor,
        ),
        minimumSize: MaterialStateProperty.all(
          Size.fromHeight(40.h),
        ),
      ),
    );
  }
}

class KOutlinedButton extends StatelessWidget {
  KOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.primaryColor = KTheme.primaryColor,
    this.secondaryColor = KTheme.secondaryColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  Color primaryColor;
  Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith(
          (states) => BorderSide(
            color: states.contains(MaterialState.pressed)
                ? secondaryColor
                : primaryColor,
            width: 2.w,
          ),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.pressed)
              ? secondaryColor
              : primaryColor,
        ),
        minimumSize: MaterialStateProperty.all(
          Size.fromHeight(40.h),
        ),
      ),
    );
  }
}
