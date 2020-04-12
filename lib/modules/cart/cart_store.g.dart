// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on _CartStore, Store {
  Computed<bool> _$fetchingComputed;

  @override
  bool get fetching =>
      (_$fetchingComputed ??= Computed<bool>(() => super.fetching)).value;
  Computed<bool> _$cartIsEmptyComputed;

  @override
  bool get cartIsEmpty =>
      (_$cartIsEmptyComputed ??= Computed<bool>(() => super.cartIsEmpty)).value;

  final _$fetchFutureAtom = Atom(name: '_CartStore.fetchFuture');

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

  final _$itemsAtom = Atom(name: '_CartStore.items');

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

  final _$itemMapsAtom = Atom(name: '_CartStore.itemMaps');

  @override
  ObservableMap<dynamic, dynamic> get itemMaps {
    _$itemMapsAtom.context.enforceReadPolicy(_$itemMapsAtom);
    _$itemMapsAtom.reportObserved();
    return super.itemMaps;
  }

  @override
  set itemMaps(ObservableMap<dynamic, dynamic> value) {
    _$itemMapsAtom.context.conditionallyRunInAction(() {
      super.itemMaps = value;
      _$itemMapsAtom.reportChanged();
    }, _$itemMapsAtom, name: '${_$itemMapsAtom.name}_set');
  }

  final _$itemListsAtom = Atom(name: '_CartStore.itemLists');

  @override
  ObservableList<dynamic> get itemLists {
    _$itemListsAtom.context.enforceReadPolicy(_$itemListsAtom);
    _$itemListsAtom.reportObserved();
    return super.itemLists;
  }

  @override
  set itemLists(ObservableList<dynamic> value) {
    _$itemListsAtom.context.conditionallyRunInAction(() {
      super.itemLists = value;
      _$itemListsAtom.reportChanged();
    }, _$itemListsAtom, name: '${_$itemListsAtom.name}_set');
  }

  final _$crudIsDoneAtom = Atom(name: '_CartStore.crudIsDone');

  @override
  bool get crudIsDone {
    _$crudIsDoneAtom.context.enforceReadPolicy(_$crudIsDoneAtom);
    _$crudIsDoneAtom.reportObserved();
    return super.crudIsDone;
  }

  @override
  set crudIsDone(bool value) {
    _$crudIsDoneAtom.context.conditionallyRunInAction(() {
      super.crudIsDone = value;
      _$crudIsDoneAtom.reportChanged();
    }, _$crudIsDoneAtom, name: '${_$crudIsDoneAtom.name}_set');
  }

  final _$metaAtom = Atom(name: '_CartStore.meta');

  @override
  ObservableMap<String, dynamic> get meta {
    _$metaAtom.context.enforceReadPolicy(_$metaAtom);
    _$metaAtom.reportObserved();
    return super.meta;
  }

  @override
  set meta(ObservableMap<String, dynamic> value) {
    _$metaAtom.context.conditionallyRunInAction(() {
      super.meta = value;
      _$metaAtom.reportChanged();
    }, _$metaAtom, name: '${_$metaAtom.name}_set');
  }

  final _$getAsyncAction = AsyncAction('get');

  @override
  Future<dynamic> get() {
    return _$getAsyncAction.run(() => super.get());
  }

  final _$getMetaAsyncAction = AsyncAction('getMeta');

  @override
  Future<void> getMeta() {
    return _$getMetaAsyncAction.run(() => super.getMeta());
  }

  final _$saveAsyncAction = AsyncAction('save');

  @override
  Future<void> save(Map<dynamic, dynamic> item, dynamic type) {
    return _$saveAsyncAction.run(() => super.save(item, type));
  }

  final _$deleteAllAsyncAction = AsyncAction('deleteAll');

  @override
  Future<void> deleteAll() {
    return _$deleteAllAsyncAction.run(() => super.deleteAll());
  }

  final _$deleteAsyncAction = AsyncAction('delete');

  @override
  Future<void> delete(Map<dynamic, dynamic> item) {
    return _$deleteAsyncAction.run(() => super.delete(item));
  }

  final _$_CartStoreActionController = ActionController(name: '_CartStore');

  @override
  void reset() {
    final _$actionInfo = _$_CartStoreActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'fetchFuture: ${fetchFuture.toString()},items: ${items.toString()},itemMaps: ${itemMaps.toString()},itemLists: ${itemLists.toString()},crudIsDone: ${crudIsDone.toString()},meta: ${meta.toString()},fetching: ${fetching.toString()},cartIsEmpty: ${cartIsEmpty.toString()}';
    return '{$string}';
  }
}
