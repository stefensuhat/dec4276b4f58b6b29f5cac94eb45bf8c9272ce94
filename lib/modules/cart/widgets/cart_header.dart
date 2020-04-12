/*
kulina_app - header
created by: stefensuhat at 11 Apr 2020 13.29
*/

import 'package:flutter/material.dart';
import 'package:kulinaapp/global/constant.dart';

class CartHeader extends StatelessWidget {
  CartHeader({@required this.isShrink});

  final bool isShrink;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      expandedHeight: 120,
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.only(
            left: spacing(isShrink ? 7 : 2), bottom: spacing(2)),
        title: Text("Review Pesanan",
            style: theme.textTheme.headline.copyWith(color: Colors.black)),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
        onPressed: () => Navigator.pushReplacementNamed(context, homePage),
      ),
      backgroundColor: Colors.white,
    );
  }
}
