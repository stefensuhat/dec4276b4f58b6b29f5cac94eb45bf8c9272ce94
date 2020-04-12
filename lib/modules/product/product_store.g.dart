// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductStore on _ProductStore, Store {
  Computed<bool> _$fetchingComputed;

  @override
  bool get fetching =>
      (_$fetchingComputed ??= Computed<bool>(() => super.fetching)).value;
  Computed<DateTime> _$beginningOfWeekComputed;

  @override
  DateTime get beginningOfWeek => (_$beginningOfWeekComputed ??=
          Computed<DateTime>(() => super.beginningOfWeek))
      .value;
  Computed<List<DateTime>> _$dateRangeComputed;

  @override
  List<DateTime> get dateRange =>
      (_$dateRangeComputed ??= Computed<List<DateTime>>(() => super.dateRange))
          .value;

  final _$fetchFutureAtom = Atom(name: '_ProductStore.fetchFuture');

  @override
  ObservableFuture<void> get fetchFuture {
    _$fetchFutureAtom.context.enforceReadPolicy(_$fetchFutureAtom);
    _$fetchFutureAtom.reportObserved();
    return super.fetchFuture;
  }

  @override
  set fetchFuture(ObservableFuture<void> value) {
    _$fetchFutureAtom.context.conditionallyRunInAction(() {
      super.fetchFuture = value;
      _$fetchFutureAtom.reportChanged();
    }, _$fetchFutureAtom, name: '${_$fetchFutureAtom.name}_set');
  }

  final _$itemsAtom = Atom(name: '_ProductStore.items');

  @override
  ObservableList<dynamic> get items {
    _$itemsAtom.context.enforceReadPolicy(_$itemsAtom);
    _$itemsAtom.reportObserved();
    return super.items;
  }

  @override
  set items(ObservableList<dynamic> value) {
    _$itemsAtom.context.conditionallyRunInAction(() {
      super.items = value;
      _$itemsAtom.reportChanged();
    }, _$itemsAtom, name: '${_$itemsAtom.name}_set');
  }

  final _$selectedDateAtom = Atom(name: '_ProductStore.selectedDate');

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.context.enforceReadPolicy(_$selectedDateAtom);
    _$selectedDateAtom.reportObserved();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.context.conditionallyRunInAction(() {
      super.selectedDate = value;
      _$selectedDateAtom.reportChanged();
    }, _$selectedDateAtom, name: '${_$selectedDateAtom.name}_set');
  }

  final _$fetchAsyncAction = AsyncAction('fetch');

  @override
  Future<void> fetch({Map<String, dynamic> query}) {
    return _$fetchAsyncAction.run(() => super.fetch(query: query));
  }

  final _$_ProductStoreActionController =
      ActionController(name: '_ProductStore');

  @override
  void setCurrentDate(dynamic date) {
    final _$actionInfo = _$_ProductStoreActionController.startAction();
    try {
      return super.setCurrentDate(date);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_ProductStoreActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'fetchFuture: ${fetchFuture.toString()},items: ${items.toString()},selectedDate: ${selectedDate.toString()},fetching: ${fetching.toString()},beginningOfWeek: ${beginningOfWeek.toString()},dateRange: ${dateRange.toString()}';
    return '{$string}';
  }
}
