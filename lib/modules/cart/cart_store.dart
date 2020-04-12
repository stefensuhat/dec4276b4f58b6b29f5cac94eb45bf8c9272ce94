/*
kulina_app - product_store
created by: stefensuhat at 11 Apr 2020 09.41
*/

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:kulinaapp/global/api.dart';
import 'package:kulinaapp/global/conf.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/models/cart.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  Dio dio = Api().dio;

  @observable
  ObservableFuture<void> fetchFuture = ObservableFuture.value(null);

  @observable
  ObservableList items = ObservableList();

  @observable
  ObservableMap itemMaps = ObservableMap();

  @observable
  ObservableList itemLists = ObservableList();

  @observable
  bool crudIsDone;

  @observable
  ObservableMap<String, dynamic> meta = ObservableMap();

  @computed
  bool get fetching => fetchFuture.status == FutureStatus.pending;

  @computed
  bool get cartIsEmpty => items.length == 0;

  @action
  Future get() async {
    items.clear();
    itemMaps.clear();

    final select =
        await db.select(table: 'carts', columns: '*', groupBy: 'date');

    final groupList = groupBy(select, (obj) => obj['date']);

    items.addAll(select);
    itemMaps.addAll(groupList);
  }

  @action
  Future<void> getMeta() async {
    final select = await db.select(
        table: 'carts',
        columns: 'SUM(qty) as qty, SUM(price * qty) as totalPrice',
        limit: 1);

    if (select.isNotEmpty) {
      final selectFirst = select[0];

      meta.clear();
      meta.addAll({
        'totalQty': selectFirst['qty'] ?? 0,
        'totalPrice': selectFirst['totalPrice'] ?? 0
      });
    }
  }

  @action
  //type = increment; decrement;
  Future<void> save(Map item, type) async {
    int countQty = 1;

    try {
      final select = await db.select(
          table: 'carts',
          where: 'product_id=${item['product_id']}; date=${item['date']}');

      if (select.isNotEmpty) {
        countQty =
            type == 'increment' ? select[0]['qty'] + 1 : select[0]['qty'] - 1;
      }

      if (countQty == 0) {
        return delete(item);
      }

      final cart = Cart(
        id: select.isNotEmpty ? select[0]['id'] : null,
        productId: item['product_id'],
        name: item['name'],
        brandName: item['brand_name'],
        price: item['price'],
        qty: countQty,
        imageUrl: item['image_url'],
        date: getDate(
            'yyyy-MM-dd',
            item['date'].runtimeType == DateTime
                ? item['date']
                : DateTime.parse(item['date'])),
      );

      if (select.isNotEmpty) {
        await cart.sqlUpdate();
      } else {
        await cart.sqlInsert();
      }

      crudIsDone = true;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> deleteAll() async {
    try {
      await db.delete(table: 'carts', where: 'id>0', verbose: true);

      crudIsDone = true;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> delete(Map item) async {
    try {
      await db.delete(
          table: 'carts',
          where: 'product_id=${item['product_id']}; date=${item['date']}');

      crudIsDone = true;
    } catch (e) {
      rethrow;
    }
  }

  @action
  void reset() {
    items.clear();
  }

  List<ReactionDisposer> _disposers = [];

  void disposers(context) {
    _disposers = [
      autorun((_) {
        getMeta();
        get();
      }),
      reaction((_) => crudIsDone, (data) {
        if (data) {
          get();
          getMeta();
          crudIsDone = false;
        }
      })
    ];
  }

  void dispose() {
    _disposers.forEach((f) => f());
  }
}
