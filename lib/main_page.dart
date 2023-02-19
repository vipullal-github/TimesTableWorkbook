import 'package:flutter/material.dart';
import 'package:times_table_workbook/route_manager.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void _gotoQuizPage(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.quizPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Times Table App"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _gotoQuizPage(context);
                  },
                  child: const Text("Take quiz")),
            ])));
  }
}
