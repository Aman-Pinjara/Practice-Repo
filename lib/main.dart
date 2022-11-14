import 'package:flutter/material.dart';
import 'package:mytests/data/graphdata.dart';
import 'package:mytests/graphs.dart';
import 'package:mytests/hivetest.dart';
import 'package:mytests/pageviewtest.dart';
import 'package:mytests/paginationTry.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<Map<String, List<String>>>("selection");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tests',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: const Graph(
      //   modeName: "OLL",
      //   modeColor: Colors.yellow,
      //   graphData: graphData,
      // ),
      home: const PageViewTest(),
    );
  }
}
