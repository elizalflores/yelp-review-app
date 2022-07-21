import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:yelp_review/services/dependency_locator.dart';
import 'package:yelp_review/main.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  testSetup();
  setUp(() {
    isTestMode = true;
  });
  await loadAppFonts();
  return testMain();
}