class BlocInjector {
  static BlocInjector _singleton = BlocInjector._internal();
  final Map<String, dynamic> _blocs = {};

  factory BlocInjector.singleton() {
    if (_singleton == null) {
      return _singleton = BlocInjector._internal();
    }
    return _singleton;
  }

  BlocInjector._internal();

  //We use for register dependencies
  void registerBloc<T>({required T dependency}) {
    _blocs[T.toString()] = dependency;
  }

  T getBloc<T>() {
    final dependency = _blocs[T.toString()];
    if (dependency == null) {
      throw Exception('Dependency not registered');
    }
    return dependency as T;
  }
}
