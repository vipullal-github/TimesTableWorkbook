// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:times_table_workbook/quiz_data.dart';
import 'package:times_table_workbook/quiz_provider.dart';

main() {
  QuizProvider provider = QuizProvider(7);
  test("Test provider states", () {
    expect(provider.state, QuizState.initPending);
    //provider.prepareQuiz();
    expect(provider.state, QuizState.quizDataReady);
    do {
      QuizItem i = provider.currentQuestion();
      print(i);
      provider.nextQuestion();
    } while (provider.state != QuizState.quizOver);
  });
}
