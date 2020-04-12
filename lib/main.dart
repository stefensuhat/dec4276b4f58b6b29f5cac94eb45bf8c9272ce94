import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kulinaapp/global/Routes.dart';
import 'package:kulinaapp/global/conf.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/global/init_db.dart';
import 'package:sqlcool/sqlcool.dart';

void main() async {
  runApp(KulinaApp());

  initDb(db: db);
}

class KulinaApp extends StatelessWidget {
  final Color kTextColor = Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kulina Testing',
      theme: ThemeData(
        primaryColor: Color(0xFFff3b30),
        fontFamily: 'Lato',
        backgroundColor: Colors.white,
        canvasColor: Colors.white,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
        textTheme: TextTheme(
          button: TextStyle(fontWeight: FontWeight.w600),
          body2: TextStyle(color: kTextColor, height: 1.25),
          body1: TextStyle(color: kTextColor, height: 1.25),
          caption: TextStyle(color: kTextColor),
          subhead: TextStyle(color: kTextColor, height: 1.25),
          overline: TextStyle(color: kTextColor),
          subtitle: TextStyle(
            fontWeight: FontWeight.w400,
            color: kTextColor,
            height: 1.25,
          ),
          title: TextStyle(
            fontWeight: FontWeight.w500,
            color: kTextColor,
            height: 1.25,
          ),
          headline: TextStyle(
            fontWeight: FontWeight.w700,
            color: kTextColor,
          ),
          display1: TextStyle(color: kTextColor, fontWeight: FontWeight.w700),
          display2: TextStyle(color: kTextColor, fontWeight: FontWeight.w600),
          display3: TextStyle(color: kTextColor),
          display4: TextStyle(color: kTextColor),
        ),
      ),
      initialRoute: homePage,
      onGenerateRoute: Routes().onGenerateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('id', 'ID')],
    );
  }
}
