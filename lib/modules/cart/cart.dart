import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/modules/cart/cart_store.dart';
import 'package:kulinaapp/modules/cart/widgets/cart_header.dart';
import 'package:kulinaapp/modules/cart/widgets/cart_item.dart';
import 'package:kulinaapp/modules/shared/cart_button.dart';

class Cart extends StatefulObserverWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  ThemeData get theme => Theme.of(context);
  ScrollController _scrollController;
  bool lastStatus = true;
  CartStore _cartStore = CartStore();

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (90 - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _cartStore.disposers(context);
  }

  @override
  Widget build(BuildContext context) {
    final Map itemMaps = _cartStore.itemMaps;
//    itemMaps.forEach((i, k) => print("i $i"));
    print(itemMaps);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            CartHeader(isShrink: isShrink),
            SliverToBoxAdapter(
              child: _cartStore.cartIsEmpty
                  ? _buildEmptyCart()
                  : Container(
                      padding: EdgeInsets.all(spacing(2)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Daftar Pesanan',
                                style: theme.textTheme.title
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              FlatButton(
                                child: Text('Hapus Pesanan'),
                                onPressed: () => _cartStore.deleteAll(),
                              ),
                            ],
                          ),
                          SizedBox(height: spacing(2)),
                          Column(
                            children: itemMaps.entries.map((entry) {
                              entry.value.map((v) => print(v));
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    getDate('EEEE, dd-MM-yyyy',
                                            DateTime.parse(entry.key))
                                        .toString(),
                                    style: theme.textTheme.title
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: spacing(2)),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _cartStore.items
                                          .where((item) =>
                                              item['date'] == entry.key)
                                          .map((i) {
                                        return CartItem(
                                            item: i, cartStore: _cartStore);
                                      }).toList()),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _cartStore.cartIsEmpty
          ? _buildEmptyButton()
          : CartButton(
              store: _cartStore,
              onClick: () {},
              children: Row(
                children: <Widget>[
                  Text(
                    'Checkout'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildEmptyButton() {
    return Container(
      padding: EdgeInsets.all(spacing(3)),
      width: double.infinity,
      child: RaisedButton(
        elevation: 0,
        padding: EdgeInsets.all(spacing(2)),
        textTheme: ButtonTextTheme.primary,
        color: theme.primaryColor,
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        child: Text('Pesan Sekarang'),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Padding(
      padding: EdgeInsets.all(spacing(3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/empty_cart.png',
            fit: BoxFit.cover,
          ),
          SizedBox(height: spacing(2)),
          Text(
            'Keranjangmu masih kosong, nih',
            style: theme.textTheme.title.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
