import 'package:flutter/material.dart';
import 'package:kulinaapp/global/constant.dart';

class QtyCounter extends StatelessWidget {
  QtyCounter({this.value, this.onClick});

  final int value;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
//        border: Border.all(color: Colors.grey[300]),
//        borderRadius: BorderRadius.circular(10.0),
          ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: OutlineButton(
              onPressed: () => onClick('increment'),
              textColor: theme.primaryColor,
              padding: EdgeInsets.all(spacing(0.5)),
              child: Icon(Icons.add),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spacing(1)),
              margin: EdgeInsets.symmetric(horizontal: spacing(1)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300], width: 2.0),
              ),
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: theme.textTheme.subhead,
              ),
            ),
          ),
          Expanded(
            child: OutlineButton(
              onPressed: () => onClick('decrement'),
              textColor: theme.primaryColor,
              padding: EdgeInsets.all(spacing(0.5)),
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}
