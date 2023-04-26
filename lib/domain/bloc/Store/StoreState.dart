// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:notes_project/domain/entities/Template.dart';

abstract class StoreState {}

class InitialStoreState extends StoreState {
  final List<Template> templates = const <Template>[];
}

class NotFoundTemplatesState extends StoreState {
  String notFoundMessage =
      'Sorry, but, your search may invalid because we not found anything template';
}

class LoadedAllTemplatesState extends StoreState {
  List<Template> templates;
  LoadedAllTemplatesState({required this.templates});

  @override
  bool operator ==(covariant LoadedAllTemplatesState other) {
    if (identical(this, other)) return true;
    return listEquals(other.templates, templates);
  }

  @override
  int get hashCode => templates.hashCode;
}

class ErrorStoreState extends StoreState {
  String error;
  ErrorStoreState({
    required this.error,
  });
}

class LoadingStoreTemplatesState extends StoreState {}

