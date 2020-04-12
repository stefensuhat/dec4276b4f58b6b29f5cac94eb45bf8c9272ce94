/*
kulina_app - init_db
created by: stefensuhat at 11 Apr 2020 21.55
*/
import 'package:flutter/material.dart';
import 'package:kulinaapp/models/cartSchema.dart';
import 'package:sqlcool/sqlcool.dart';

Future<void> initDb(
    {@required Db db, String path = "dbs.sqlite", bool absPath = false}) async {
  // define the tables
  await db
      .init(
          path: path, schema: [cartTable], absolutePath: absPath, verbose: true)
      .catchError((dynamic e) {
    throw ("Error initializing the database: ${e.message}");
  });
  print("Database initialized with schema:");
  db.schema.describe();
}
