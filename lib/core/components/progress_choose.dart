import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/AddTaskPage/Manager/adding_task_cubit.dart';

class ProgressChoose extends StatefulWidget {
  const ProgressChoose({
    super.key,
    required this.progressChooseActive,
    this.value,
  });

  final bool progressChooseActive;
  final String? value; // Can be "low", "TaskProgress.waiting", etc.

  @override
  _ProgressChooseState createState() => _ProgressChooseState();
}

class _ProgressChooseState extends State<ProgressChoose> {
  late String selectedProgress;

  final List<String> progressOptions = [
    'Waiting',
    'Inprogress',
    'Finished',
  ];

  @override
  void initState() {
    super.initState();

    final input = widget.value?.toLowerCase();
    debugPrint(input);
    selectedProgress = switch (input) {
      'waiting' || 'TaskProgress.waiting' => 'Waiting',
      'inprogress' || 'taskprogress.inprogress' => 'Inprogress',
      'finished' || 'taskprogress.finished' => 'Finished',
      _ => 'Waiting',
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
          absorbing: !widget.progressChooseActive,
          child: DropdownButton<String>(
            value: selectedProgress,
            dropdownColor: priorityColor,
            iconEnabledColor: mainColor,
            underline: const SizedBox(),
            isExpanded: true,
            icon: Image.asset("assets/arrow_down.png"),
            borderRadius: BorderRadius.circular(10),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedProgress = newValue;
                });

                final mappedValue = switch (newValue) {
                  'Waiting' => 'waiting',
                  'Inprogress' => 'inprogress',
                  'Finished' => 'finished',
                  _ => 'low',
                };

                context.read<AddingTaskCubit>().setProgress(mappedValue);
              }
            },
            items: progressOptions.map((String value) {
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
            }).toList(),
          ),
        ),
      ),
    );
  }
}
