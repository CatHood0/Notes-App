import 'package:notes_project/main.dart';

class Injector {
  static Injector _singleton = Injector._internal();
  final Map<String, dynamic> _dependencies = {};
  final Map<String, dynamic> _services = {};
  factory Injector.singleton() {
    if (_singleton == null) {
      return _singleton = Injector._internal();
    }
    return _singleton;
  }

  Injector._internal();

  //We use also record sevices
  void registerService<T>({required T service}) {
    _services[service.toString()] = service;
  }

  T getService<T>() {
    final service = _services[T.toString()];
    if (service == null) {
      throw Exception('Dependency not registered');
    }
    return service as T;
  }

  //We use for register dependencies
  void registerDependency<T>({required T dependency}) async {
    _dependencies[T.toString()] = dependency;
  }

  T getDependency<T>() {
    final dependency = _dependencies[T.toString()];
    if (dependency == null) {
      throw Exception('Dependency not registered');
    }
    return dependency as T;
  }
}
