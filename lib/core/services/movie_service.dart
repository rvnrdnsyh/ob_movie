import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moviedb/core/common/constants.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/providers/dio_provider.dart';
import 'package:moviedb/core/providers/storeage_provider.dart';

final movieServiceProvider =
    Provider((ref) => MovieService(ref.read(dioProvider), ref.read(storageProvider)));

class MovieService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  MovieService(this._dio, this._secureStorage);

  Future<List<Movie>> getPopularMovie(int page) async {
    List<Movie> movies = [];
    var response = await _dio.get(
        '${API_URL}discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_watch_monetization_types=flatrate');

    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var movieRes in response.data['results']) {
          Movie newMovie = new Movie(
            movieRes['id'],
            movieRes['title'],
            double.parse(movieRes['vote_average'].toString()),
            'https://www.themoviedb.org/t/p/w300${movieRes['poster_path']}',
            'https://www.themoviedb.org/t/p/w780${movieRes['backdrop_path']}',
          );
          movies.add(newMovie);
        }
      }
    }

    return movies;
  }

  Future<List<Movie>> getUpcoming(int page, int pageSize) async {
    List<Movie> movies = [];
    var response = await _dio
        .get('${API_URL}movie/upcoming?api_key=$API_KEY&language=en-US&page=1');

    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var movieRes in response.data['results']) {
          Movie newMovie = new Movie(
              movieRes['id'],
              movieRes['title'],
              double.parse(movieRes['vote_average'].toString()),
              'https://www.themoviedb.org/t/p/w300${movieRes['poster_path']}',
              'https://www.themoviedb.org/t/p/w780${movieRes['backdrop_path']}');
          movies.add(newMovie);
          if (movies.length == pageSize) {
            break;
          }
        }
      }
    }

    return movies;
  }

  Future<MovieDetailPreVideoAndCast> getMovieDetails(int id) async {
    var movieDetail;
    var response =
        await _dio.get('${API_URL}movie/$id?api_key=$API_KEY&language=en-US');

    if (response.data != null) {
      movieDetail = MovieDetailPreVideoAndCast(
          response.data['id'],
          response.data['original_title'],
          double.parse(response.data['vote_average'].toString()),
          'https://www.themoviedb.org/t/p/w300${response.data['poster_path']}',
          'https://www.themoviedb.org/t/p/w780${response.data['backdrop_path']}',
          response.data['genres'],
          response.data['vote_count'],
          response.data['overview'],
          response.data['video']);
    }
    return movieDetail;
  }

  Future<MovieDetailWithCast> getMovieCast(MovieDetailPreVideoAndCast params) async {
    List<MovieCast> moviesCast = [];
    var response = await _dio.get(
        '${API_URL}movie/${params.id}/credits?api_key=$API_KEY&language=en-US');

    if (response.data.length > 0) {
      if (response.data['cast'].length > 0) {
        for (var res in response.data['cast']) {
          MovieCast newMovieCast = new MovieCast(
              res['name'],
              res['id'],
              'https://www.themoviedb.org/t/p/w300${res['profile_path']}',
              res['gender']);
          moviesCast.add(newMovieCast);
        }
      }
    }
    var movieDetail = MovieDetailWithCast(
      params.id,
      params.title,
      params.rating,
      params.poster,
      params.backdrop,
      params.genres,
      params.voted,
      params.synopsis,
      params.video,
      moviesCast,
    );
    // print(movieDetail.toString());
    return movieDetail;
  }

  Future<MovieDetails> getMovieTrailer(MovieDetailWithCast params) async {
    List <Trailer> trailers = [];
    var response = await _dio.get(
        '${API_URL}movie/${params.id}/videos?api_key=$API_KEY&language=en-US');
    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var res in response.data['results']) {
          Trailer newTrailer = new Trailer(
              res['key'],
              res['site'],);
          trailers.add(newTrailer);
        }
      }
    }

    var favoritedMovie = await _secureStorage.read(key: 'favoritedMovie');
    var checkFavorited = false;
    if (favoritedMovie != null) {
      List<int> favoritedMovieList = List.from(jsonDecode(favoritedMovie.toString()));
      checkFavorited = favoritedMovieList.contains(params.id);
    }
    print(checkFavorited);
    var index = trailers.indexWhere((element) => element.site == 'YouTube');
    var youtubeKey = trailers[index].key;
    var movieDetail = MovieDetails(
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
      youtubeKey,
      checkFavorited,
    );
    return movieDetail;
  }
}
