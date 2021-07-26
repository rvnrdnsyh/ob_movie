import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/auth/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool actionWidget;
  final Color? backgroundColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.actionWidget,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  // TODO: implement child
  // Widget get child => throw UnimplementedError();
  Widget get child => Text(
        'Movies',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final photoUrl = FirebaseAuth.instance.currentUser!.photoURL ??
        "https://industrial.uii.ac.id/wp-content/uploads/2019/09/385-3856300_no-avatar-png.jpg";
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actionWidget ? [
        PopupMenuButton(
          onSelected: (value) => context
              .read(authViewModelProvider.notifier)
              .handlePopupMenu(value),
          child: CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
            radius: 25,
          ),
          itemBuilder: (context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 0,
              child: Text('Sign Out'),
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
      ] : [],
      backgroundColor: Color(0XFF191926),
      shadowColor: Colors.transparent,
      centerTitle: true,
    );
  }
}
