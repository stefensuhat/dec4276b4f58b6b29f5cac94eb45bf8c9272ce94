import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/modules/cart/cart_store.dart';
import 'package:kulinaapp/modules/product/product_store.dart';
import 'package:kulinaapp/modules/product/widgets/qty_counter.dart';
import 'package:kulinaapp/modules/shared/network_image.dart';
import 'package:kulinaapp/modules/shared/number_format.dart';

class ProductList extends StatefulObserverWidget {
  ProductList({this.cartStore, this.productStore});

  final CartStore cartStore;
  final ProductStore productStore;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ThemeData get theme => Theme.of(context);

  CartStore get _cartStore => widget.cartStore;

  ProductStore get _productStore => widget.productStore;

  void addToCart(Map item, type) {
    item['product_id'] = item['id'];

    _cartStore.save(item, type);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List carts = _cartStore.items;
    final List items = _productStore.items;

    print(carts);

    final double itemHeight = size.height / 4;
    final double itemWidth = size.width / 5;

    return Container(
      padding: EdgeInsets.all(spacing(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            getDate('EEEE, d MMMM yyyy', _productStore.selectedDate),
            style: theme.textTheme.headline.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spacing(2)),
          GridView.builder(
            primary: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: spacing(1),
              mainAxisSpacing: spacing(2),
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(carts, items[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(List carts, Map item) {
    Map findItem = carts.firstWhere((i) {
      if (item != null) {
        String formatted = getDate('yyyy-MM-dd', DateTime.parse(i['date']));
        String formattedItem =
            getDate('yyyy-MM-dd', _productStore.selectedDate);
        bool checkIfDateIsSame = formatted == formattedItem;
        return i['product_id'] == item['id'] && checkIfDateIsSame;
      }
      return false;
    }, orElse: () => {});

    item['date'] = _productStore.selectedDate;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CustomImage(
              url: item['image_url'],
              width: (MediaQuery.of(context).size.width - 32) / 2,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.green,
                  label: Text('Baru'.toUpperCase(),
                      style: TextStyle(color: Colors.white)),
                ),
                Text(
                  item['name'],
                  style: theme.textTheme.subhead
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  item['brand_name'],
                  style: theme.textTheme.subtitle
                      .copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          SizedBox(height: spacing(1)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: NumberFormat(amount: item['price']).money(),
                    style: theme.textTheme.subhead
                        .copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' termasuk ongkir',
                        style: theme.textTheme.caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing(1)),
                findItem.isNotEmpty
                    ? QtyCounter(
                        value: findItem['qty'],
                        onClick: (type) => addToCart(item, type),
                      )
                    : OutlineButton(
                        onPressed: () => addToCart(item, 'increment'),
                        textColor: theme.primaryColor,
                        borderSide: BorderSide(color: theme.primaryColor),
                        child: Text('Tambah ke Keranjang'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
