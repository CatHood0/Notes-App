abstract class ISearch<T> {
  Future<List<T>> search({required String text});
}
