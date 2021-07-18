import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/favorite/favorite_view_model.dart';
import 'package:moviedb/favorite/widget/favorite_movie_card.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => context.read(favoriteViewModelProvider.notifier).loadData());

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorite Movies',
            style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0XFF191926),
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Consumer(builder: (context, watch, child) {
      final state = watch(favoriteViewModelProvider);
      if (state is Loading) {
        return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            alignment: Alignment.center,
            child: CircularProgressIndicator());
      } else if (state.data.length == 0) {
        return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "You don't have a favorite movie",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
        );
      } else {
        return Container(
          child: ListView.builder(
              itemCount: state.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CardFavoriteMovie(
                  key: Key(index.toString()),
                  state: state.data[index],
                  index: index,
                  lastIndex: state.data.length - 1,
                );
              }),
        );
      }
    }));
  }
}
