import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/services/movie_service.dart';

final movieDetailViewModelProvider = StateNotifierProvider((ref) => MovieDetailViewModel(ref.read(movieServiceProvider)));

class MovieDetailViewModel extends StateNotifier {
  MovieService _movieService;
  MovieDetailViewModel(this._movieService) : super(Initial({}));

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

}