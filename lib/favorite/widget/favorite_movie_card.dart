import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/core/models/favorite.dart';
import 'package:moviedb/favorite/favorite_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardFavoriteMovie extends StatelessWidget {
  final FavoritedMovie state;
  final int index;
  final int lastIndex;

  const CardFavoriteMovie(
      {required Key key,
      required this.state,
      required this.index,
      required this.lastIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 350,
      margin: EdgeInsets.only(
          top: index == 0 ? 12 : 6,
          left: 12,
          right: 12,
          bottom: index == lastIndex ? 12 : 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: RadialGradient(
              radius: 0.3, colors: [Color(0XFF404056), Color(0XFF222232)])),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: 166,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  image: DecorationImage(
                    image: NetworkImage(state.poster),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                  child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 0.99],
                  ),
                ),
              )),
              Positioned(
                child: Container(
                  height: 25,
                  width: 35,
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Center(
                      child: Text(state.ageRating,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold))),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  height: 26,
                  width: 26,
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap: () => context
                        .read(favoriteViewModelProvider.notifier)
                        .handleFavorite(state.id),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 6,
                bottom: 25,
                child: Container(
                  width: 160,
                  child: Text(
                    state.genres,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 6,
                bottom: 10,
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.pink,
                      size: 10,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.pink,
                      size: 10,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.pink,
                      size: 10,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.pink,
                      size: 10,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.pink,
                      size: 10,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${state.reviews} REVIEWS',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF6D6D80)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0XFFECECEC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${state.duration.toString()} MIN',
                      style: TextStyle(
                        color: Color(0XFF6D6D80),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        state.synopsis,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () => {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [Color(0XFF8036E7), Color(0XFFFF3365)],
                            ),
                          ),
                          height: 25,
                          width: 197,
                          child: Text(
                            "BOOK YOUR TICKET",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
