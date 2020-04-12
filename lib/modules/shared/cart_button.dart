import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/modules/cart/cart_store.dart';
import 'package:kulinaapp/modules/shared/number_format.dart';

class CartButton extends StatelessObserverWidget {
  CartButton({this.store, @required this.children, @required this.onClick});

  final CartStore store;
  final Widget children;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return store.meta.isEmpty || store.meta['totalPrice'] == 0
        ? Container(width: 0, height: 0)
        : GestureDetector(
            onTap: () => onClick(),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: spacing(2)),
              color: theme.primaryColor,
              elevation: 10,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: spacing(1), horizontal: spacing(1.5)),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '${store.meta['totalQty']} Item | ${NumberFormat(amount: store.meta['totalPrice']).money()}',
                            style: theme.textTheme.subhead.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Termasuk ongkos kirim',
                            style: theme.textTheme.subhead.copyWith(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: children,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
