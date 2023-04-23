import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_project/data/repositories/Store_repository.dart';
import 'package:notes_project/injector/dependency_injector.dart';

void main() {
  final Injector inject =
      Injector.singleton(); //we inject here our dependencies
  test('should get to me a dependency that i want', () async {
    inject.registerDependency<StoreRepository>(dependency: StoreRepository());
    final StoreRepository interface = inject.getDependency<StoreRepository>();
    expect(interface, inject.getDependency<StoreRepository>());
  });

  test('should get authenticate user', () async {
    
  });
}
