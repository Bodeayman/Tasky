import 'package:flutter/material.dart';
import 'package:tasky/core/utils/constants.dart';
import 'package:tasky/core/utils/style/colors.dart';

InputDecoration inputStyle = InputDecoration(
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kborderSize),
      borderSide: BorderSide(color: inputFieldBorderColor, width: 1)),
);

BoxDecoration disabledStyle = const BoxDecoration(
  color: Colors.grey,
);
