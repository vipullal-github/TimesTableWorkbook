import 'dart:async';

import 'package:flutter/material.dart';
import 'package:times_table_workbook/quiz_data.dart';
import 'dart:math';

enum QuizState {
  initPending,
  quizDataReady,
  beginCountdownTimer,
  onStartQuiz,
  updateCurrentItem,
  acceptingAnswer,
  quizInProgress,
  quizOver
}

class QuizProvider extends ChangeNotifier {
  final int _numQuestions;
  final int _multiplier;
  int _currentQuestion = 0;
  List<QuizItem> quizItems = [];

  QuizState _currentState = QuizState.initPending;
  QuizState get state => _currentState;
  int get multiplier => _multiplier;

  QuizProvider(this._multiplier, [this._numQuestions = 20]) {
    _currentState = QuizState.initPending;
    _startQuizGeneration();
  }

  void _startQuizGeneration() {
    scheduleMicrotask(() {
      quizItems = _generateQuizItems(_numQuestions);
      _currentState = QuizState.quizDataReady; // UI shown StartQuiz button
      notifyListeners();
    });
  }

  List<QuizItem> _generateQuizItems(int count) {
    assert(_currentState == QuizState.initPending);
    assert(count >= 0);
    List<QuizItem> items = [];
    Random r = Random(TimeOfDay.now().minute);
    for (int i = 0; i < count; i++) {
      int multiplicand = r.nextInt(12);
      QuizItem qi = QuizItem(multiplicand, multiplicand * _multiplier);
      items.add(qi);
    }
    return items;
  }

  // called when the user presses the StartButton...
  void startQuiz() {
    _currentQuestion = 0;
    _currentState = QuizState.beginCountdownTimer;
    notifyListeners();
  }

  void onCountdownComplete() {
    _currentState = QuizState.onStartQuiz;
    notifyListeners();
  }

  QuizItem getCurrentItem() {
    assert(_currentQuestion < quizItems.length);
    return quizItems[_currentQuestion];
  }

  void onQuizDisplayed() {}

  void onCurrentItemDrawn() {
    _currentState = QuizState.acceptingAnswer;
    notifyListeners();
  }

  void onKeyPressed(String key) {
    print("QuizProvider handeling key $key");
    switch (key) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        QuizItem qi = quizItems[_currentQuestion];
        int a = qi.answerGiven;
        a = a * 10 + int.parse(key);
        // Limit to two digits only
        if (a < 99) {
          qi.answerGiven = a;
          notifyListeners();
        }
        break;
      case 'Bsp':
        QuizItem qi = quizItems[_currentQuestion];
        int a = qi.answerGiven;
        a = 0;
        qi.answerGiven = a;
        notifyListeners();
        break;
      case 'Ok':
        if (_currentQuestion + 1 < quizItems.length) {
          ++_currentQuestion;
        } else {
          _currentQuestion = 0; // todo: Change state to quz Over
        }
        notifyListeners();
        break;
    }
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
