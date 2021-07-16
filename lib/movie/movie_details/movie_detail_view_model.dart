import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/providers/storeage_provider.dart';
import 'package:moviedb/core/services/movie_service.dart';

final movieDetailViewModelProvider = StateNotifierProvider((ref) =>
    MovieDetailViewModel(
        ref.read(movieServiceProvider), ref.read(storageProvider)));

class MovieDetailViewModel extends StateNotifier {
  MovieService _movieService;
  FlutterSecureStorage _secureStorage;
  MovieDetailViewModel(this._movieService, this._secureStorage)
      : super(Initial({}));

  void loadData(id) async {
    state = Loading(state.data);
    try {
      var movieDetail1 = await _movieService.getMovieDetails(id);
      var movieDetail2 = await _movieService.getMovieCast(movieDetail1);
      var movieDetail = await _movieService.getMovieTrailer(movieDetail2);
      state = Success(movieDetail);
    } catch (exception) {
      state = Error('Something went wrong', state.data);
    }
  }

  void setFavorite(int id, MovieDetails params) async {
    var stringList = await _secureStorage.read(key: 'favoritedMovie');
    print(stringList);
    if (stringList == null) {
      List<int> newList = [id];
      String newListJson = jsonEncode(newList);
      await _secureStorage.write(key: 'favoritedMovie', value: newListJson);
    } else {
      List<int> movieIdList = List.from(jsonDecode(stringList.toString()));

      if (movieIdList.contains(id)) {
        var newMovieIdList = movieIdList.where((x) => x != id).toList();
        await _secureStorage.write(
            key: 'favoritedMovie', value: newMovieIdList.length > 0 ? jsonEncode(newMovieIdList) : null);
      } else {
        movieIdList.add(id);
        await _secureStorage.write(
            key: 'favoritedMovie', value: jsonEncode(movieIdList));
      }
    }
    state = Success(MovieDetails(
        params.id,
        params.title,
        params.rating,
        params.poster,
        params.backdrop,
        params.genres,
        params.voted,
        params.synopsis,
        params.video,
        params.cast,
        params.trailerPath,
        !params.favorited));
  }
}
