import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/favorite.dart';
import 'package:moviedb/core/services/favorite_service.dart';

final favoriteViewModelProvider =
    StateNotifierProvider.autoDispose<FavoriteViewModel, AsyncState<List<FavoritedMovie>>>(
        (ref) => FavoriteViewModel(ref.read(favoriteServiceProvider)));

class FavoriteViewModel extends StateNotifier<AsyncState<List<FavoritedMovie>>> {
  final FavoriteService _favoriteService;
  FavoriteViewModel(this._favoriteService) : super(Initial([])) {
    loadData();
  }

  void loadData() async {
    state = Loading(state.data);
    try {
      var favoritedMovies = await _favoriteService.getFavoriteMovie();
      state = Success(favoritedMovies);
    } catch (exception) {
      state = Error('Something went wrong', state.data);
    }
  }
}
