import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/modules/product/product_store.dart';

class Calendar extends StatefulObserverWidget {
  Calendar({this.productStore});

  final ProductStore productStore;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  ProductStore get productStore => widget.productStore;

  final items = List<String>.generate(14, (i) => "Item $i");

  int currentIndex = 3;

  // type = prev;next
  void handleArrowClick(slider, type) {
    final jump = type == 'prev' ? currentIndex - 7 : currentIndex + 7;

    if (jump < 1 || jump > 56) {
      return;
    }
    slider.animateToPage(jump,
        duration: Duration(milliseconds: 300), curve: Curves.linear);

    setState(() {
      currentIndex = jump;
    });
  }

  void handleDateClick(DateTime date) {
    if (date.weekday == 6 || date.weekday == 7) {
      return;
    }

    productStore.setCurrentDate(date);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final slider = CarouselSlider(
      items: productStore.dateRange.map(
        (item) {
          TextStyle calendarStyle = TextStyle(fontWeight: FontWeight.bold);
          if (item.weekday == 6 || item.weekday == 7) {
            calendarStyle = TextStyle(color: Colors.grey[400]);
          }

          String formatted = getDate('yyyy-MM-dd', productStore.selectedDate);
          String formattedItem = getDate('yyyy-MM-dd', item);
          bool checkIfDateIsSame = formatted == formattedItem;

          if (checkIfDateIsSame) {
            calendarStyle =
                TextStyle(color: Colors.orange, fontWeight: FontWeight.bold);
          }

          return GestureDetector(
            onTap: () => handleDateClick(item),
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      checkIfDateIsSame
                          ? Colors.orange[100]
                          : Colors.transparent,
                      checkIfDateIsSame ? Colors.white : Colors.transparent,
                    ],
                    tileMode: TileMode.mirror,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.all(spacing(1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(getDate('EEE', item), style: calendarStyle),
                    Text(getDate('d', item), style: calendarStyle),
                  ],
                )),
          );
        },
      ).toList(),
      height: 65,
      viewportFraction: 0.15,
      initialPage: currentIndex,
      enableInfiniteScroll: false,
      reverse: false,
      autoPlay: false,
      enlargeCenterPage: false,
      scrollDirection: Axis.horizontal,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spacing(1)),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          bottom: BorderSide(color: Colors.grey[300], width: 2),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 35,
            height: 35,
            margin: EdgeInsets.only(right: 0),
            child: RaisedButton(
              color: Colors.white,
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.arrow_back_ios,
                color: theme.primaryColor,
                size: 16,
              ),
              onPressed: () => handleArrowClick(slider, 'prev'),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: spacing(1)),
                child: slider),
          ),
          Container(
            width: 35,
            height: 35,
            child: RaisedButton(
              color: Colors.white,
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: theme.primaryColor,
                size: 16,
              ),
              onPressed: () => handleArrowClick(slider, 'next'),
            ),
          ),
        ],
      ),
    );
  }
}
