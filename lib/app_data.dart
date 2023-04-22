import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  final String appTitle = "Times Table App";

  int _lastTableChosen = 7;
  int get lastTable => _lastTableChosen;
  set lastTable(int value) => _lastTableChosen = value;
}
