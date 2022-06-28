import 'package:flutter/material.dart';

class YelpDivider extends StatelessWidget {
  final double? indents;

  const YelpDivider({Key? key, this.indents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dividerTheme = Theme.of(context).dividerTheme;
    return Divider(
      height: dividerTheme.space,
      thickness: dividerTheme.thickness,
      color: dividerTheme.color,
      indent: indents ?? dividerTheme.indent,
      endIndent: dividerTheme.endIndent,
    );
  }
}
