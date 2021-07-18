import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/favorite.dart';
import 'package:moviedb/core/providers/storeage_provider.dart';
import 'package:moviedb/core/services/favorite_service.dart';

final favoriteViewModelProvider = StateNotifierProvider.autoDispose<
        FavoriteViewModel, AsyncState<List<FavoritedMovie>>>(
    (ref) => FavoriteViewModel(
        ref.read(favoriteServiceProvider), ref.read(storageProvider)));

class FavoriteViewModel
    extends StateNotifier<AsyncState<List<FavoritedMovie>>> {
  final FavoriteService _favoriteService;
  final FlutterSecureStorage _secureStorage;
  FavoriteViewModel(this._favoriteService, this._secureStorage)
      : super(Initial([])) {
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

  void handleFavorite(int id) async {
    var listId = await _secureStorage.read(key: 'favoritedMovie');
    List<int> newListId = List.from(jsonDecode(listId.toString()));
    var _newListId = newListId.where((x) => x != id).toList();
    await _secureStorage.write(key: 'favoritedMovie', value: jsonEncode(_newListId));
    var currentState = state.data;
    var newData = currentState.where((x) => x.id != id).toList();
    state = Success(newData);
  }
}
