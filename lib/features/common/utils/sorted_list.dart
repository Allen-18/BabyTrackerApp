class SortedUniqueList<T> {
  final List<T> _items;
  final int Function(T a, T b) _compareFn;

  SortedUniqueList(this._compareFn) : _items = [];

  bool add(T item) {
    final index = _findFirstIndexWhere((element) => _compareFn(element, item));
    if (index < _items.length && _compareFn(item, _items[index]) == 0) {
      return false;
    }
    _items.insert(index, item);
    return true;
  }

  bool remove(T item) {
    if (items.isEmpty) return false;
    final index = _findFirstIndexWhere((element) => _compareFn(element, item));
    if (_compareFn(item, _items[index]) != 0) {
      return false;
    } else {
      _items.removeAt(index);
      return true;
    }
  }

  bool update(T newItem) {
    if (items.isEmpty) return false;
    final index =
        _findFirstIndexWhere((element) => _compareFn(element, newItem));
    if (index < _items.length && _compareFn(_items[index], newItem) == 0) {
      _items[index] = newItem;
      return true;
    } else {
      return false;
    }
  }

  int _findFirstIndexWhere(int Function(T element) test) {
    var start = 0;
    var end = _items.length;
    while (start < end) {
      final mid = start + ((end - start) >> 1);
      final res = test(_items[mid]);
      if (res == 0) return mid;
      if (res > 0) {
        end = mid;
      } else {
        start = mid + 1;
      }
    }
    return start;
  }

  List<T> get items => List.unmodifiable(_items);
}
