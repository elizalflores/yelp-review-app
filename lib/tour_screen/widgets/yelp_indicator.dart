import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class YelpIndicator extends StatelessWidget {
  final Widget child;
  final AsyncCallback onRefresh;

  const YelpIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mockLoading ? const Icon(
      Icons.refresh,
      color: Colors.blue,
    ) : RefreshIndicator(
        onRefresh: onRefresh,
        child: child,
    );
  }
}
