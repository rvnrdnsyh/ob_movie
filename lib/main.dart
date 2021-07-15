import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/main_tab/main_tab_screen.dart';
import 'package:moviedb/movie/movie_details/movie_details.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Data',
      theme: ThemeData(
          // appBarTheme: AppBarTheme(
          //   shadowColor: Colors.transparent,
          //   backgroundColor: Colors.transparent,
          // ),
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Color.fromRGBO(25, 25, 38, 100),
          textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => MainTabScreen(),
        '/movieDetails': (context) => MovieDetails()
      },
    );
  }
}
