import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsProvider = Provider((ref) => FirebaseAnalytics());

final observerProvider = Provider((ref) => FirebaseAnalyticsObserver(analytics: ref.read(analyticsProvider)));