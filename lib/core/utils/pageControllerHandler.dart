import 'package:flutter/material.dart';

class PageControllerHandler {
  final PageController pageController;

  // Constructor to initialize the controller
  PageControllerHandler(this.pageController);

  // Method to go to a specific page
  void goToPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
