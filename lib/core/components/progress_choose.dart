import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Manager/adding_task_cubit.dart';

class ProgressChoose extends StatefulWidget {
  const ProgressChoose({super.key});

  @override
  _ProgressChooseState createState() => _ProgressChooseState();
}

class _ProgressChooseState extends State<ProgressChoose> {
  String selectedPriority = "Waiting";

  final List<String> priorities = [
    'Waiting',
    'Inprogress',
    'Finished',
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kborderSize),
      child: Container(
        color: priorityColor,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButton<String>(
          value: selectedPriority,
          dropdownColor: priorityColor,
          iconEnabledColor: mainColor,
          underline: const SizedBox(),
          isExpanded: true,
          icon: Image.asset(
            "assets/arrow_down.png",
          ),
          borderRadius: BorderRadius.circular(10),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedPriority = newValue;
              });
              final mappedValue = switch (newValue) {
                "Waiting" => "low",
                "Inprogress" => "medium",
                "Finished" => "high",
                _ => "medium",
              };
              context.read<AddingTaskCubit>().setPriority(mappedValue);
            }
          },
          items: priorities.map(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 18,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
