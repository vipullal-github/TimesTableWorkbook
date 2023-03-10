import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_page.dart';
import 'screens/quiz_screen/quiz_page.dart';
import 'quiz_provider.dart';

class RouteManager {
  static const String homePage = '/';
  static const String quizPage = '/quizPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainPage());
      case quizPage:
        return MaterialPageRoute(builder: (context) {
          return ChangeNotifierProvider(create: (context) {
            return QuizProvider(7);
          }, builder: (context, child) {
            return Consumer<QuizProvider>(builder: (context, value, child) {
              return QuizPage(value);
            });
          });
        });
      default:
        throw FormatException("Route ${settings.name} not found!");
    }
  }
}
