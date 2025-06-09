import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/AddTaskPage/Manager/adding_task_cubit.dart';

class PriorityChoose extends StatefulWidget {
  const PriorityChoose(
      {super.key, required this.PriorityChooseActive, this.value});
  final bool PriorityChooseActive;
  final String? value;
  @override
  _PriorityChooseState createState() => _PriorityChooseState();
}

class _PriorityChooseState extends State<PriorityChoose> {
  late String selectedPriority;

  final List<String> priorities = [
    'Low Priority',
    'Medium Priority',
    'High Priority',
  ];

  @override
  void initState() {
    super.initState();

    selectedPriority = switch (widget.value) {
      "low" || "TaskBadges.low" => "Low Priority",
      "medium" || "TaskBadges.medium" => "Medium Priority",
      "high" || "TaskBadges.high" => "High Priority",
      _ => "Medium Priority",
    };
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kborderSize),
      child: Container(
        color: priorityColor,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AbsorbPointer(
          absorbing: !widget.PriorityChooseActive,
          child: DropdownButton<String>(
            value: selectedPriority,
            dropdownColor: priorityColor,
            iconEnabledColor: mainColor,
            underline: const SizedBox(),
            isExpanded: true,
            icon: Image.asset("assets/arrow_down.png"),
            borderRadius: BorderRadius.circular(10),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedPriority = newValue;
                });
                final mappedValue = switch (newValue) {
                  "Low Priority" => "low",
                  "Medium Priority" => "medium",
                  "High Priority" => "high",
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
      ),
    );
  }
}
