import 'package:flutter/material.dart';
import 'main_page.dart';
import 'quiz_page.dart';

class RouteManager {
  static const String homePage = '/';
  static const String quizPage = '/quizPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainPage());
      case quizPage:
        return MaterialPageRoute(builder: (context) { return const QuizPage();});
      default:
        throw FormatException("Route ${settings.name} not found!");
    }
  }
}
