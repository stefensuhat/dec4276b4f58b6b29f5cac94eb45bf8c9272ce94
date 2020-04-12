import 'package:flutter/material.dart';

class QtyCounter extends StatelessWidget {
  QtyCounter({this.value, this.onClick});

  final int value;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => onClick('decrement'),
            icon: Icon(Icons.remove),
          ),
          Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: theme.textTheme.title,
          ),
          IconButton(
            onPressed: () => onClick('increment'),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
