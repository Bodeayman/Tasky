import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/style/colors.dart';
import 'package:tasky/cubits/page_cubit.dart'; // assuming you have these colors

class AllTabsWidget extends StatefulWidget {
  const AllTabsWidget({super.key});

  @override
  State<AllTabsWidget> createState() => _AllTabsWidgetState();
}

class _AllTabsWidgetState extends State<AllTabsWidget> {
  final List<String> tabs = const ["All", "InProgress", "Waiting", "Finished"];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
                context.read<PageCubit>().changePageNumber(index);
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                isSelected ? mainColor : Colors.grey.shade200,
              ),
              foregroundColor: WidgetStateProperty.all(
                isSelected ? Colors.white : Colors.grey.shade600,
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
              overlayColor: WidgetStateProperty.all(
                mainColor.withOpacity(0.2),
              ),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}
