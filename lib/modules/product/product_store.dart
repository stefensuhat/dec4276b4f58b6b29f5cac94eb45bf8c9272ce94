/*
kulina_app - product_store
created by: stefensuhat at 11 Apr 2020 09.41
*/

import 'package:dio/dio.dart';
import 'package:kulinaapp/global/api.dart';
import 'package:mobx/mobx.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store {
  final Dio dio = Api().dio;

  @observable
  ObservableFuture<void> fetchFuture = ObservableFuture.value(null);

  @observable
  ObservableList items = ObservableList();

  @observable
  DateTime selectedDate = DateTime.now();

  @computed
  bool get fetching => fetchFuture.status == FutureStatus.pending;

  @computed
  DateTime get beginningOfWeek {
    final currentWeekday = DateTime.now().weekday;

    if (currentWeekday == 6) {
      return DateTime.now().add(Duration(days: 2));
    } else if (currentWeekday == 7) {
      return DateTime.now().add(Duration(days: 1));
    } else {
      return DateTime.now()
          .subtract(Duration(days: DateTime.now().weekday - 1));
    }
  }

  @computed
  List<DateTime> get dateRange => List<DateTime>.generate(
      56, (i) => beginningOfWeek.add(Duration(days: i)));

  @action
  Future<void> fetch({Map<String, dynamic> query}) async {
    if (query == null) {
      query = {"limit": 2, "page": 1};
    }

    final future = dio.get('/products', queryParameters: query);

    fetchFuture = ObservableFuture(future.then((onValue) {
      final response = onValue.data;

      items.addAll(response['data']);
    }));
  }

//  @action

  @action
  void setCurrentDate(date) {
    if (date == null) {
      selectedDate = DateTime.now();
      addDate(currentDate: selectedDate);
    } else {
      selectedDate = date;
    }
  }

  void addDate({DateTime currentDate, add: 1}) {
    final date = currentDate.add(Duration(days: add));

    if (date.weekday == 7 || date.weekday == 6) {
      return addDate(currentDate: date, add: add + 1);
    }

    selectedDate = date;
  }

  @action
  void reset() {
    items.clear();
  }

  List<ReactionDisposer> _disposers = [];

  void disposers(context) {
    _disposers = [
      reaction((_) => selectedDate, (data) {
        items.clear();
        fetch();
      })
    ];
  }

  void dispose() {
    _disposers.forEach((f) => f());
  }
}
