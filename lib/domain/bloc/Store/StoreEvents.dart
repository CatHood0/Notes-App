// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../entities/Template.dart';

abstract class StoreEvent {}

class SearchTemplateEvent extends StoreEvent {
  String search;
  SearchTemplateEvent({
    required this.search,
  });
}

class SaveTemplateEvent extends StoreEvent {
  final Template template;
  final int index;
  SaveTemplateEvent({required this.template, required this.index});
}

class CreateTemplateEvent extends StoreEvent {
  final Template template;
  CreateTemplateEvent({required this.template});
}

class DeleteTemplateEvent extends StoreEvent {
  final int id;
  final int index;
  DeleteTemplateEvent({required this.id, required this.index});
}

class UpdateTemplateEvent extends StoreEvent {
  final Template template;
  final int index;
  UpdateTemplateEvent({required this.template, required this.index});
}

class LikedTemplateEvent extends StoreEvent {
  final int like;
  final String id;
  final int index;
  LikedTemplateEvent(
      {required this.index, required this.like, required this.id});
}

class ShareTemplateEvent extends StoreEvent {
  final int sharedTemplate;
  final bool confirmedShared;
  final int index;
  ShareTemplateEvent({required this.sharedTemplate, required this.index, required this.confirmedShared});
}

class DislikeTemplateEvent extends StoreEvent {
  final int like;
  final String id;
  final int index;
  DislikeTemplateEvent({
    required this.like,
    required this.id,
    required this.index,
  });
}