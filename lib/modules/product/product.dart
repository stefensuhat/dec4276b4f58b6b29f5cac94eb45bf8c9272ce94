/*
kulina - ProductLis
created by: stefensuhat at 10 Apr 2020 22.22
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kulinaapp/global/conf.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/modules/cart/cart_store.dart';
import 'package:kulinaapp/modules/product/product_list.dart';
import 'package:kulinaapp/modules/product/product_store.dart';
import 'package:kulinaapp/modules/product/widgets/calendar.dart';
import 'package:kulinaapp/modules/shared/cart_button.dart';
import 'package:kulinaapp/modules/shared/progress.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Product extends StatefulObserverWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  ThemeData get theme => Theme.of(context);
  ProductStore _productStore = ProductStore();
  CartStore _cartStore = CartStore();

  DateTime selectedDate = DateTime.now().add(Duration(days: 1));

  int page = 0;
  int limit = 4;

  @override
  void initState() {
    super.initState();
//    fetchData();

    db.onReady.then((_) {
      print("STATE: THE DATABASE IS READY");
      _productStore.disposers(context);
      _cartStore.disposers(context);
      _productStore.setCurrentDate(null);
    });
  }

  void fetchData() {
    setState(() {
      page++;
    });
    _productStore.fetch(query: {'_page': page, '_limit': limit});
  }

  @override
  void dispose() {
    _productStore.dispose();
    _cartStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool fetching = _productStore.fetching;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(spacing(0)),
        child: Container(),
      ),
      body: LazyLoadScrollView(
        onEndOfPage: fetchData,
        child: ListView(
          children: <Widget>[
            // Header
            Padding(
              padding: EdgeInsets.all(spacing(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Alamat Pengantaran'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  Text('Kulina', style: theme.textTheme.headline)
                ],
              ),
            ),

            StickyHeader(
              header: Calendar(productStore: _productStore),
              content: ProductList(
                productStore: _productStore,
                cartStore: _cartStore,
              ),
            ),

            fetching ? Progress() : Container(),
          ],
        ),
      ),
      floatingActionButton: CartButton(
          store: _cartStore,
          onClick: () => Navigator.pushNamed(context, cartPage),
          children: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
