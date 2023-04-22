import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_table_workbook/route_manager.dart';
import '../../app_data.dart';
import 'dart:developer' as dev;

class MultiplierChooserPage extends StatelessWidget {
  const MultiplierChooserPage({super.key});

  void _startQuizForTable(BuildContext context, int multiplier) {
    dev.log("Starting quiz for multiplier $multiplier");
    AppData data = Provider.of<AppData>(context, listen: false);
    data.lastTable = multiplier;
    Navigator.of(context).pushNamed(RouteManager.quizPage);
  }

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
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
          _startQuizForTable(context, i);
        },
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(data.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: itemsList,
        ),
      ),
    );
  }
}
