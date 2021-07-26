import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/services/auth_service.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncState<UserCredential>>(
        (ref) => AuthViewModel(ref.read(authServiceProvider)));

class AuthViewModel extends StateNotifier<AsyncState<UserCredential>> {
  final AuthService _authService;
  AuthViewModel(this._authService) : super(Initial(null));

  void handleSignInFacebook() async {
    state = Loading(state.data);
    try {
      var auth = await _authService.signInWithFacebook();
      print('INI AUTH FACEBOOK: $auth');
      state = Success(auth);
    } catch (error) {
      state = Error('Something went wrong', state.data);
    }
  }

  void handleSignInGoogle() async {
    state = Loading(state.data);
    try {
      var auth = await _authService.signInWithGoogle();
      print('INI AUTH GOOGLE: $auth');
      state = Success(auth);
    } catch (error) {
      state = Error('Something went wrong', state.data);
    }
  }

  void handlePopupMenu(value) {
    if (value == 0) {
      _authService.signOut();
    }
  }
}
