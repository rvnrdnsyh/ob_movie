import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/auth/widget/login_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoginWidget(),
      ),
    );
  }
}
