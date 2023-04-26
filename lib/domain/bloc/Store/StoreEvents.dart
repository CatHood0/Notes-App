// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../entities/Template.dart';

abstract class StoreEvent {}

class RecommendTemplateEvent extends StoreEvent {}

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

class SearchTemplateEvent extends StoreEvent {
  String search;
  SearchTemplateEvent({
    required this.search,
  });
}

class SavePrivateTemplateEvent extends StoreEvent {
  final Template template;
  final int index;
  SavePrivateTemplateEvent({required this.template, required this.index});
}

class LikedTemplateEvent extends StoreEvent {
  final int like;
  final String id;
  final int index;
  LikedTemplateEvent(
      {required this.index, required this.like, required this.id});
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

class ShareTemplateEvent extends StoreEvent {
  final int sharedTemplate;
  final bool confirmedShared;
  final String urlTemplate; //the id from template
  final String email; //messages with the template
  final int index;
  ShareTemplateEvent(
      {required this.urlTemplate,
      required this.email,
      required this.sharedTemplate,
      required this.index,
      required this.confirmedShared});
}
