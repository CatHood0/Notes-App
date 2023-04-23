abstract class ICrud<T> {
  Future<void> create({required T obj});
  Future<void> update({required T obj});
  Future<void> delete({required String idObj});
}
