import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moviedb/auth/login_screen.dart';
import 'package:moviedb/main_tab/main_tab_screen.dart';

final authServiceProvider = Provider((ref) => AuthService());

class AuthService {
  handleAuthStatus() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (contex, snapshot) {
          if (snapshot.hasData) {
            return MainTabScreen();
          } else {
            return LoginScreen();
          }
        },
    );
  }

  Future<UserCredential> signInWithFacebook() async {
    final fb = FacebookLogin();
    final resLogin = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    final FacebookAccessToken? accessToken = resLogin.accessToken;
    final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken!.token);
    var result = await FirebaseAuth.instance.signInWithCredential(authCredential);
    // switch(resLogin.status) {
    //   case FacebookLoginStatus.success:
    //     final FacebookAccessToken? accessToken = resLogin.accessToken;
    //     final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken!.token);
    //     result = await FirebaseAuth.instance.signInWithCredential(authCredential);
    //     break;
    //   case FacebookLoginStatus.cancel:
    //     break;
    //   case FacebookLoginStatus.error:
    //     print('Error while log in: ${resLogin.error}');
    //     break;
    // }
    return result;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );
    var result = await FirebaseAuth.instance.signInWithCredential(credential);
    return result;
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

}