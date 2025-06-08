import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/features/Presentation/AddTaskPage/Manager/adding_task_cubit.dart';

class ProgressChoose extends StatefulWidget {
  const ProgressChoose({
    super.key,
    required this.progressChooseActive,
    this.value,
  });

  final bool progressChooseActive;
  final String? value; // Can be "waiting", "inprogress", or "finished"

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

  /// Maps backend value to dropdown label
  String _mapValueToLabel(String? value) {
    switch (value?.toLowerCase()) {
      case 'waiting':
        return 'Waiting';
      case 'inprogress':
        return 'Inprogress';
      case 'finished':
        return 'Finished';
      default:
        return 'Waiting';
    }
  }

  /// Maps dropdown label to backend value
  String _mapLabelToValue(String label) {
    switch (label) {
      case 'Waiting':
        return 'waiting';
      case 'Inprogress':
        return 'inprogress';
      case 'Finished':
        return 'finished';
      default:
        return 'waiting';
    }
  }

  @override
  void initState() {
    super.initState();
    selectedProgress = _mapValueToLabel(widget.value);
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

                final mappedValue = _mapLabelToValue(newValue);
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
