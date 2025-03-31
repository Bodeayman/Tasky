import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';

class CalenderButton extends StatelessWidget {
  const CalenderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        showDatePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year, DateTime.now().month),
          lastDate: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
        );
      },
      keyboardType: TextInputType.datetime,
      decoration: inputStyle.copyWith(
        suffixIcon: Icon(Icons.date_range_rounded, color: mainColor),
        hintText: "choose due date...",
      ),
    );
  }
}
