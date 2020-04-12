/*
kulina_app - cartSchema.dart
created by: stefensuhat at 11 Apr 2020 22.40
*/

import 'package:sqlcool/sqlcool.dart';

final cartTable = DbTable("carts")
  ..integer("product_id")
  ..varchar("name")
  ..varchar("brand_name")
  ..integer("price")
  ..integer("qty")
  ..varchar("image_url")
  ..varchar("date");
