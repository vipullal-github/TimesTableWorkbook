// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

// Global data. This provider wraps the MaterialApp so it is available
// on every route...
class AppData extends ChangeNotifier {
  final String appTitle = "Times Table App";

  int _lastTableChosen = 7;
  int get lastTable => _lastTableChosen;
  set lastTable(int value) => _lastTableChosen = value;

  int _maxQuestions= 5;
  int get maxQuestions => _maxQuestions;
  set maxQuestions(int value) => _maxQuestions = value;

}
