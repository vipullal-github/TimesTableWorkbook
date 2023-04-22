import 'dart:async';

import 'package:flutter/material.dart';
import 'package:times_table_workbook/models/quiz_data.dart';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:times_table_workbook/models/quiz_results_model.dart';

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

  int get currentIndex => _currentQuestion + 1;
  int get maxQuestions => _numQuestions;

  QuizProvider(this._multiplier, [this._numQuestions = 5]) {
    _currentState = QuizState.initPending;
    _startQuizGeneration();
  }

  QuizResults getQuizResults() {
    int numCurrect = quizItems.fold(0, (previousValue, QuizItem item) {
      if (item.answerGiven == item.correctAnswer) {
        return ++previousValue;
      }
      return previousValue;
    });
    return QuizResults(_multiplier, _numQuestions, numCurrect, 0);
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
      int multiplicand = 0;
      do {
        multiplicand = r.nextInt(12);
      } while (multiplicand == 0);
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

  void onQuizPainterReady() {
    _currentState = QuizState.quizInProgress;
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
    dev.log("QuizProvider handeling key $key, quizState is $state");
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
        QuizItem qi = quizItems[_currentQuestion];
        qi.isCorrect = qi.answerGiven == qi.correctAnswer;
        if (_currentQuestion + 1 < quizItems.length) {
          ++_currentQuestion;
        } else {
          _currentState = QuizState.quizOver;
          _currentQuestion = 0;
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
