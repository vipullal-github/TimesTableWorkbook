import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_table_workbook/route_manager.dart';

import 'my_app_bar.dart';
import 'app_data.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void _gotoSelectPracticeOrQuiz(BuildContext context, int multipler) {
    AppData data = Provider.of<AppData>(context, listen: false);
    data.lastTable = multipler;
    Navigator.of(context).pushNamed(RouteManager.choseModePage);
  }

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    TextStyle headingStyle = Theme.of(context).textTheme.headlineMedium!;
    List<Widget> itemsList = [];

    itemsList.add(
      Text(
        "Please choose a table...",
        style: headingStyle,
      ),
    );
    for (int i = 2; i <= 9; i++) {
      itemsList.add(ListTile(
        title: Text("$i"),
        onTap: () {
          _gotoSelectPracticeOrQuiz(context, i);
        },
      ));
    }

    return Scaffold(
      appBar: MyAppBar( screenName: data.appTitle),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: itemsList,
        ),
      ),
    );
  }
}
