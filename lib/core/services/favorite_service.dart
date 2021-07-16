import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moviedb/core/common/constants.dart';
import 'package:moviedb/core/models/favorite.dart';
import 'package:moviedb/core/providers/dio_provider.dart';
import 'package:moviedb/core/providers/storeage_provider.dart';

final favoriteServiceProvider = Provider(
    (ref) => FavoriteService(ref.read(dioProvider), ref.read(storageProvider)));

class FavoriteService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  FavoriteService(this._dio, this._secureStorage);

  Future<List<FavoritedMovie>> getFavoriteMovie() async {
    List<FavoritedMovie> favortitedMovies = [];
    var favoritedMovie = await _secureStorage.read(key: 'favoritedMovie');
    if (favoritedMovie != null) {
      List<int> favoritedMovieList =
          List.from(jsonDecode(favoritedMovie.toString()));
      for (var id in favoritedMovieList) {
        var res = await _dio
            .get('${API_URL}movie/$id?api_key=$API_KEY&language=en-US');
        // var res2 = await _dio
        //     .get('${API_URL}movie/$id/release_dates?api_key=$API_KEY');
        String ageRating = '';
        // if (res2.data.length > 0) {
        //   List tmp = res2.data['results'];
        //   var index = tmp.length > 0 ? tmp.indexWhere((x) => x.iso_3166_1 == 'US') : 0;
        //   List newTmp = index != 0 ? tmp[index].release_dates : [];
        //   var newIndex = newTmp.length > 0 ? newTmp.indexWhere((z) => z.certification != '') : 0;
        //   ageRating = newIndex != 0 ? newTmp[newIndex].certification : '';
        // }
        if (res.data.length > 0) {
          List<String> tmp = [];
          for (var el in res.data['genres']) {
            tmp.add(el['name']);
          }
          var genreString = tmp.join(', ');
          print(genreString);
          FavoritedMovie favoritedMovie = new FavoritedMovie(
              res.data['id'],
              res.data['title'],
              double.parse(res.data['vote_average'].toString()),
              'https://www.themoviedb.org/t/p/w300${res.data['poster_path']}',
              'https://www.themoviedb.org/t/p/w780${res.data['backdrop_path']}',
              genreString,
              res.data['vote_count'],
              res.data['runtime'],
              res.data['overview'],
              ageRating);
          favortitedMovies.add(favoritedMovie);
        } else {
          throw Exception('no data!');
        }
      }
    }

    return favortitedMovies;
  }
}
