import 'package:flutter_test/flutter_test.dart';
import 'package:times_table_workbook/quiz_data.dart';
import 'package:times_table_workbook/quiz_provider.dart';

main() {
  QuizOrovider provider = QuizOrovider(7);
  test("Test provider states", () {
    expect(provider.state, QuizState.initPending);
    provider.prepareQuiz();
    expect(provider.state, QuizState.paused);
    do {
      QuizItem i = provider.currentQuestion();
      print(i);
      provider.nextQuestion();
    } while (provider.state != QuizState.quizOver);
  });
}
