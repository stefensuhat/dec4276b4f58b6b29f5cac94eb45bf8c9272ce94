import 'package:flutter/material.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/modules/cart/cart_store.dart';
import 'package:kulinaapp/modules/cart/widgets/qty_counter.dart';
import 'package:kulinaapp/modules/shared/network_image.dart';
import 'package:kulinaapp/modules/shared/number_format.dart';

class CartItem extends StatelessWidget {
  CartItem({@required this.item, @required this.cartStore});

  final Map item;
  final CartStore cartStore;

  void handleDeleteClick(item) {
    cartStore.delete(item);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: spacing(3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CustomImage(
              url: item['image_url'],
              width: (MediaQuery.of(context).size.width - 32 - 20) / 3,
            ),
          ),
          SizedBox(width: spacing(1)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item['name'],
                        style: theme.textTheme.title
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.grey,
                      onPressed: () => handleDeleteClick(item),
                    ),
                  ],
                ),
                Text(
                  item['brand_name'].toString(),
                  style: theme.textTheme.subhead.copyWith(color: Colors.grey),
                ),
                SizedBox(height: spacing(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      NumberFormat(amount: item['qty'] * item['price']).money(),
                      style: theme.textTheme.title,
                    ),
                    QtyCounter(
                      value: item['qty'],
                      onClick: (type) => cartStore.save(item, type),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
