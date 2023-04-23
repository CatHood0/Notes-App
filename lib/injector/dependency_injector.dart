import 'package:notes_project/main.dart';

class Injector {
  static Injector _singleton = Injector._internal();
  final Map<String, dynamic> _dependencies = {};

  factory Injector.singleton() {
    if(_singleton==null){
      return _singleton = Injector._internal();
    }
    return _singleton;
  }

  Injector._internal();


  void registerDependency<T>({required T dependency}) {
    _dependencies[T.toString()] = dependency;
  }

  T getDependency<T>() {
    final dependency = _dependencies[T.toString()];
    if (dependency == null) {
      throw Exception('Dependency not registered');
    }
    return dependency as T;
  }

 @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Injector && runtimeType == other.runtimeType;

  @override
  int get hashCode => Injector.singleton().hashCode;

}