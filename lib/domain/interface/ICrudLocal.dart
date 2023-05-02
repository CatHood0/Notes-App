abstract class ICrudLocal<T> {
  Future<int> create({required T obj});
  Future<void> update({required T obj});
  Future<void> delete({required int id});
}