mixin ISearch<T> {
  Future<List<T>> search({required String text});
}
