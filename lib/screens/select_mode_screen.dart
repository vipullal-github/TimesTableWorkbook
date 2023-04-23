import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_table_workbook/route_manager.dart';

import '../app_data.dart';

class SelectModeScreen extends StatelessWidget {
  const SelectModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    const spacer = SizedBox(height: 10);
    TextStyle headingStyle = Theme.of(context).textTheme.headlineSmall!;

    void gotoPracticeScreen(BuildContext context) {
      Navigator.of(context).pushNamed(RouteManager.practiceScreen);
    }

    void gotoQuizScreen(BuildContext context) {
      Navigator.of(context).pushNamed(RouteManager.quizPage);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data.appTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("What would you like to do?", style: headingStyle),
              spacer,
              ElevatedButton(
                onPressed: () {
                  gotoPracticeScreen(context);
                },
                child: Text("Learn the ${data.lastTable} times table"),
              ),
              spacer,
              ElevatedButton(
                onPressed: () {
                  gotoQuizScreen(context);
                },
                child: Text("Take a quiz on the ${data.lastTable} times table"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
