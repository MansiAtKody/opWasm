import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/ui/routing/navigation_stack_item.dart';

final navigationStackProvider = ChangeNotifierProvider((ref) => NavigationStack([
      const NavigationStackItem.splash(),
    ]));

//final navigationStackProvider = ChangeNotifierProvider((ref) => NavigationStack([]));

@injectable
class NavigationStack with ChangeNotifier {
  List<NavigationStackItem> _items;

  NavigationStack(@factoryParam List<NavigationStackItem> items) : _items = List.of(items);

  UnmodifiableListView<NavigationStackItem> get items => UnmodifiableListView(_items);

  NavigationStackItem? currentScreen;

  set items(List<NavigationStackItem> newItems) {
    _items = List.from(newItems);
    notifyListeners();
  }

  void push(NavigationStackItem item) {
    _items.add(item);
    currentScreen = _items.last;
    notifyListeners();
  }

  void pop() {
    if (_items.length > 1) {
      _items.removeLast();
      currentScreen = _items.last;
      notifyListeners();
    }
  }

  void popUntil(NavigationStackItem until) {
    if (_items.isNotEmpty) {
      int index = _items.indexWhere((element) => element == until);
      _items.removeRange(index + 1, _items.length);
      currentScreen = _items.last;
      notifyListeners();
    }
  }

  void pushRemove(NavigationStackItem item) {
    if (_items.isNotEmpty) {
      _items.removeLast();
      _items.add(item);
      currentScreen = _items.last;
      notifyListeners();
    }
  }

  void pushRemoveUntil(NavigationStackItem item, NavigationStackItem until) {
    if (_items.isNotEmpty) {
      int index = _items.indexWhere((element) => element == until);
      _items.removeRange(index + 1, _items.length);
      _items.add(item);
      currentScreen = _items.last;
      notifyListeners();
    }
  }

  void pushAndRemoveAll(NavigationStackItem item) {
    if (_items.isNotEmpty) {
      _items.clear();
      _items.add(item);
      currentScreen = _items.last;
      notifyListeners();
    }
  }
}
