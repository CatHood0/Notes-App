class Injector {
  static Injector _singleton = Injector._internal();
  final Map<String, dynamic> _instances = {};

  factory Injector.singleton() {
    return _singleton;
  }

  Injector._internal();

  //We use for register dependencies
  void registerInstance<T>({required T instance}) async {
    _instances[T.toString()] = instance;
  }

  T Get<T>() {
    final instance = _instances[T.toString()];
    if (instance == null) {
      throw Exception('instance not registered');
    }
    return instance as T;
  }
}
