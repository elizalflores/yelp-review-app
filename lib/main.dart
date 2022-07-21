import 'package:flutter/material.dart';
import 'package:yelp_review/yelp_app.dart';

import 'services/dependency_locator.dart';


var isTestMode = false;

void main() {
  setupDependencies();

  return runApp(const YelpApp());
}
