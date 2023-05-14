// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:times_table_workbook/app_data.dart';
import 'package:times_table_workbook/models/quiz_data.dart';
import 'package:times_table_workbook/quiz_provider.dart';

main() {
  AppData data = AppData();
  QuizProvider provider = QuizProvider( data );
  test("Test provider states", () {
    expect(provider.state, QuizState.initPending);
    provider.addListener(() {
      
    },);
    //provider.prepareQuiz();
    expect(provider.state, QuizState.quizDataReady);
    do {
      QuizItem i = provider.currentQuestion();
      print(i);
      provider.nextQuestion();
    } while (provider.state != QuizState.quizOver);
  });
}
