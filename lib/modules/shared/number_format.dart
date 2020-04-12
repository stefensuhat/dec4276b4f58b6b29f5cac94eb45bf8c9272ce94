/*
kulina_app - number_format
created by: stefensuhat at 11 Apr 2020 16.44
*/

/*
app - money
created by: stefensuhat at 18 Oct 2019 11:16
*/

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class NumberFormat {
  NumberFormat({@required this.amount, this.showSymbol = false});

  dynamic amount;
  final bool showSymbol;

  static final MoneyFormatterSettings settings = MoneyFormatterSettings(
    symbol: 'Rp.',
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolAndNumberSeparator: ' ',
    fractionDigits: 0,
  );

  String show() {
    switch (amount.runtimeType) {
      case int:
        amount = amount + 0.0;
        break;
      default:
        amount = amount;
    }

    FlutterMoneyFormatter fmf =
        FlutterMoneyFormatter(amount: amount, settings: settings);

    return _output(fmf);
  }

  String money() {
    switch (amount.runtimeType) {
      case int:
        amount = amount + 0.0;
        break;
      default:
        amount = amount;
    }

    FlutterMoneyFormatter fmf =
        FlutterMoneyFormatter(amount: amount, settings: settings);

    return fmf.output.symbolOnLeft;
  }

  _output(FlutterMoneyFormatter fmf) {
    if (showSymbol) {
      return fmf.output.symbolOnLeft;
    }

    return fmf.output.nonSymbol;
  }
}
