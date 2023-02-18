import 'package:flutter/material.dart';
import 'package:times_table_workbook/quiz_data.dart';
import 'dart:math';

enum QuizState { initPending, paused, quizInProgress, quizOver }

class QuizOrovider extends ChangeNotifier {
  final int _numQuestions;
  final int _multiplier;
  int _currentQuestion = 0;
  List<QuizItem> quizItems = [];

  QuizState _currentState = QuizState.initPending;
  QuizState get state => _currentState;
  int get multiplier => _multiplier;

  QuizOrovider(this._multiplier, [this._numQuestions = 20]);

  void prepareQuiz() {
    assert(_currentState == QuizState.initPending);
    assert(_numQuestions >= 0);
    Random r = Random(TimeOfDay.now().minute);
    for (int i = 0; i < _numQuestions; i++) {
      int multiplicand = r.nextInt(12);
      QuizItem qi = QuizItem(multiplicand, multiplicand * _multiplier);
      quizItems.add(qi);
    }
    _currentState = QuizState.paused;
    _currentQuestion = 0;
  }

  QuizItem currentQuestion() {
    return quizItems[_currentQuestion];
  }

  void nextQuestion() {
    if (_currentQuestion + 1 < _numQuestions) {
      ++_currentQuestion;
    } else {
      _currentState = QuizState.quizOver;
    }
    notifyListeners();
  }
}
