class Paginacion {
  int _limit;
  int _offset;

  Paginacion({required int limit, required int offset})
    : _limit = limit,
      _offset = offset;

  int get limit => _limit;

  int get offset => _offset;

  set setLimit(int newLimit) => _limit = newLimit;

  void nextPage() => _offset += _limit;

  void previousPage() {
    if (_offset == 0) return;

    _offset -= _limit;

    if (_offset < 0) {
      _offset = 0;
    }
  }
}
