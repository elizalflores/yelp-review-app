import 'dart:async';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/main.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  isTestMode = true;
  await loadAppFonts();
  return testMain();
}