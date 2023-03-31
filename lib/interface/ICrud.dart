mixin ICrud<T> {
  Future<List<T>> getAllData({required String keyUser});
  Future<void> create({required T object});
  Future<void> update({required T object});
  Future<void> delete({required String key});
}
