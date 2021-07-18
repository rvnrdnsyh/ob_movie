import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/core/providers/firebase_analytics_provider.dart';
import 'package:moviedb/movie/widgets/popular/popular_movies.dart';
import 'package:moviedb/movie/widgets/upcoming/upcoming_movies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read(analyticsProvider).logEvent(name: 'Movie_screen');
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              UpcomingMovies(),
              SizedBox(height: 20),
              PopularMovies()
            ],
          ),
        ),
      )
    );
  }
}