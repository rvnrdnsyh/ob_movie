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
            height: 400,
            width: double.infinity,
            alignment: Alignment.center,
            child: CircularProgressIndicator());
      } else {
        return Container(
          child: ListView.builder(
              itemCount: state.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CardFavoriteMovie(
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
