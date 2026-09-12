class Paginacion {
  int _limit;
  int _offset;
  int _total;

  Paginacion({required int limit, required int offset, int total = 0})
    : _limit = limit,
      _offset = offset,
      _total = total;

  int get limit => _limit;

  int get offset => _offset;

  int get total => _total;

  set setLimit(int newLimit) => _limit = newLimit;

  set setTotal(int newTotal) => _total = newTotal;

  void nextPage() {
    _offset += _limit;
  }

  void previousPage() {
    if (_offset == 0) return;

    _offset -= _limit;

    if (_offset < 0) {
      _offset = 0;
    }
  }
}
