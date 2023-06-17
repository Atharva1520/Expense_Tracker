import 'package:expense_tracker/widgets/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const myApp());
}

var kcolour = ColorScheme.fromSeed(seedColor: Color.fromRGBO(14, 41, 84, 100));
var kcolour3 =
    ColorScheme.fromSeed(seedColor: Color.fromRGBO(132, 167, 161, 100));
var kcolour2 =
    ColorScheme.fromSeed(seedColor: Color.fromRGBO(46, 138, 153, 100));
var kcolour1 =
    ColorScheme.fromSeed(seedColor: Color.fromRGBO(31, 110, 140, 100));
var kdarkcolor = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 5, 95, 125));

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kdarkcolor,
      ),
      theme: ThemeData().copyWith(
          useMaterial3: true,
          appBarTheme: AppBarTheme().copyWith(
              backgroundColor: kcolour.onPrimaryContainer,
              foregroundColor: Colors.white),
          cardTheme: CardTheme().copyWith(
            color: kcolour2.primaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          textTheme: ThemeData().textTheme.copyWith(),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style:
                  ElevatedButton.styleFrom(primary: kcolour3.primaryContainer)),
          scaffoldBackgroundColor: kcolour1.primaryContainer),
      debugShowCheckedModeBanner: false,
      home: Expenses(),
      themeMode: ThemeMode.light,
    );
  }
}
