import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/auth/auth_view_model.dart';
import 'package:moviedb/core/models/async_state.dart';

class LoginWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(authViewModelProvider);
    if (state is Loading) {
      return Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          alignment: Alignment.center,
          child: CircularProgressIndicator());
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello, \nWelcome, login with,",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gesture detector for facebook Login
              GestureDetector(
                onTap: () => context
                    .read(authViewModelProvider.notifier)
                    .handleSignInFacebook(),
                child: Image.network(
                  "https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-file-facebook-icon-svg-wikimedia-commons-4.png",
                  width: 50,
                ),
              ),
              SizedBox(width: 50),
              GestureDetector(
                onTap: () => context
                    .read(authViewModelProvider.notifier)
                    .handleSignInGoogle(),
                child: Image.network(
                  "https://www.freepnglogos.com/uploads/google-plus-png-logo/download-google-brand-vector-png-logos-18.png",
                  width: 50,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
