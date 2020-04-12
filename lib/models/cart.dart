/*
kulina_app - cart
created by: stefensuhat at 11 Apr 2020 22.11
*/

import 'package:kulinaapp/models/cartSchema.dart';
import 'package:sqlcool/sqlcool.dart';
import 'package:kulinaapp/global/conf.dart' as conf;

class Cart with DbModel {
  Cart({
    this.id,
    this.name,
    this.price,
    this.qty,
    this.date,
    this.imageUrl,
    this.productId,
    this.brandName,
  });

  final String name;
  final String brandName;
  final int price;
  final int qty;
  final String date;
  final String imageUrl;
  final int productId;

  @override
  int id;

  @override
  Db get db => conf.db;

  @override
  DbTable get table => cartTable;

  /// serialize a row to the database
  @override
  Map<String, dynamic> toDb() {
    final row = <String, dynamic>{
      'product_id': productId,
      'name': name,
      'brand_name': brandName,
      'price': price,
      'qty': qty,
      'image_url': imageUrl,
      'date': date,
    };

    return row;
  }

  /// deserialize a row from database
  @override
  Cart fromDb(Map<String, dynamic> map) {
    final cart = Cart(
      id: map["id"] as int,
      productId: map['product_id'] as int,
      name: map["name"].toString(),
      brandName: map["brand_name"].toString(),
      imageUrl: map["image_url"].toString(),
      date: map["date"].toString(),
      price: map["price"] as int,
      qty: map["qty"] as int,
    );

    return cart;
  }

  /// Create a static join method for convenience
  static Future<List<Cart>> selectRelated({String where, int limit}) async {
    final carts = List<Cart>.from(
        await Cart().sqlJoin(where: where, limit: limit, verbose: true));
    return carts;
  }
}
