import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/providers/firebase_analytics_provider.dart';
import 'package:moviedb/main_tab/main_tab_screen.dart';
import 'package:moviedb/movie/movie_details/movie_details.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();

}

class MyAppState extends State {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  Future<void> setupInterectedMessage (BuildContext context) async {
    await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data);
      if (message.data['path'] != null && message.data['argument'] != null) {
        var argument = int.tryParse(message.data['argument']) ?? message.data['argument'];
        navigatorKey.currentState!.pushNamed(message.data['path'], arguments: argument);
      } else if (message.data['path'] != null) {
        navigatorKey.currentState!.pushNamed(message.data['path']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await setupInterectedMessage(context);
    });

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Movie Data',
      navigatorObservers: [
        context.read(observerProvider)
      ],
      theme: ThemeData(
          // appBarTheme: AppBarTheme(
          //   shadowColor: Colors.transparent,
          //   backgroundColor: Colors.transparent,
          // ),
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Color(0XFF191926),
          textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => MainTabScreen(),
        '/movieDetails': (context) => MovieDetails()
      },
    );
  }
}
