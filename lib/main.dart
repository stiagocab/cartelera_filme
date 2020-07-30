import 'package:filme/src/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:filme/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black87,
        secondaryHeaderColor: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.grey[850],
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline5: TextStyle(
            fontSize: 22.0,
            fontStyle: FontStyle.italic,
            color: Colors.blueGrey[200],
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            fontWeight: FontWeight.normal,
            color: Colors.blueGrey,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
            color: Colors.amber,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: "/",
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetailsPage(),
      },
    );
  }
}
