import 'package:flutter/material.dart';
import 'package:todog/todog_colors.dart';

import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Dog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: ToDogColors.kabul,
        primaryColor: ToDogColors.bbb,
      ),
      home: HomePage(),
    );
  }
}
