import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  Progress({this.boxSize = 24});

  final double boxSize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: boxSize,
        height: boxSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
        ),
      ),
    );
  }
}
