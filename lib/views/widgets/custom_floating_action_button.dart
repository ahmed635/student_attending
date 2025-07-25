import 'package:flutter/material.dart';
import 'package:student_attending/config/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  void Function()? onPressed;

  CustomFloatingActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: AppColors.primary,
      onPressed: onPressed,
      child: Icon(Icons.add, color: AppColors.white),
    );
  }
}
