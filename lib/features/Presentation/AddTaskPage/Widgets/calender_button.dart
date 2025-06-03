import 'package:flutter/material.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/core/utils/style/inputStyle.dart';

class CalendarButton extends StatefulWidget {
  const CalendarButton({super.key});

  @override
  State<CalendarButton> createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      // Format the date as you want
      final formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {
        _controller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onTap: () async {
        // Prevent keyboard from showing up
        FocusScope.of(context).requestFocus(FocusNode());
        await _pickDate();
      },
      readOnly: true,
      keyboardType: TextInputType.datetime,
      decoration: inputStyle.copyWith(
        suffixIcon: Icon(Icons.date_range_rounded, color: mainColor),
        hintText: "choose due date...",
      ),
    );
  }
}
