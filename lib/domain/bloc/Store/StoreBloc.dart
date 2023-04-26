import 'dart:async';
import 'package:notes_project/domain/bloc/Store/StoreEvents.dart';
import 'package:notes_project/domain/bloc/Store/StoreState.dart';
import '../../entities/Template.dart';

class StoreBloc {
  List<Template> _templates = [];
  final _templateStateController = StreamController<StoreState>.broadcast(
    onListen: () => print("Listening note states"),
    onCancel: () => print("Cancelling note state"),
  );
  final _currentTemplateController = StreamController<Template>.broadcast();
  final _eventStreamController = StreamController<StoreEvent>();
  Stream<StoreState> get stateStream => _templateStateController.stream;
  StreamSink<StoreEvent> get eventSink => _eventStreamController.sink;

  StoreBloc() {
    _templateStateController.add(InitialStoreState());
    _eventStreamController.stream.listen(_handleEvents);
  }

  void _handleEvents(StoreEvent event) {
    if (event is CreateTemplateEvent) {
      _templateStateController.add(LoadingStoreTemplatesState());
      _templates.add(event.template);
      _currentTemplateController.add(event.template);
      _templateStateController
          .add(LoadedAllTemplatesState(templates: _templates));
    } else if (event is UpdateTemplateEvent) {
      _templateStateController.add(LoadingStoreTemplatesState());
      _templates[event.index] = event.template;
      _templateStateController
          .add(LoadedAllTemplatesState(templates: _templates));
    } else if (event is DeleteTemplateEvent) {
      _templates.removeAt(event.index);
      _templateStateController
          .add(LoadedAllTemplatesState(templates: _templates));
    } else if (event is SearchTemplateEvent) {
    } else if (event is DislikeTemplateEvent) {
      _templateStateController.add(LoadingStoreTemplatesState());
      _templates[event.index] =
          _templates[event.index].copyWith(likes: event.like - 1);
      _templateStateController
          .add(LoadedAllTemplatesState(templates: _templates));
    } else if (event is LikedTemplateEvent) {
      _templateStateController.add(LoadingStoreTemplatesState());
      _templates[event.index] =
          _templates[event.index].copyWith(likes: event.like + 1);
      _templateStateController
          .add(LoadedAllTemplatesState(templates: _templates));
    } else if (event is ShareTemplateEvent) {
      if (event.confirmedShared) {
        _templates[event.index] =
            _templates[event.index].copyWith(shares: event.sharedTemplate + 1);
      }
      _templateStateController
          .add(LoadedAllTemplatesState(templates: _templates));
    }
  }

  int get lastIndexAdded => _templates.length;

  Stream<Template> lastTemplateAdded() async*{
    yield* _currentTemplateController.stream;
  }

  void dispose() {
    _eventStreamController.close();
    _templateStateController.close();
  }
}
