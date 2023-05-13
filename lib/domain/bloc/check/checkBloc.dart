import 'dart:async';
import '../../entities/check.dart';
part 'checkEvent.dart';
part 'checkState.dart';

class CheckBloc {
  List<Check> _checks = [];

  //stream controllers
  final StreamController<CheckState> _stateController =
      StreamController<CheckState>.broadcast();
  final StreamController<CheckEvent> _eventController =
      StreamController<CheckEvent>();
  final StreamController<int> _stateCountTask = StreamController<int>();

  //getters
  Stream<int> get streamCount => _stateCountTask.stream;
  StreamSink<CheckEvent> get eventSink => _eventController.sink;
  Stream<CheckState> get stream => _stateController.stream;

  CheckBloc({required CheckState initial}) {
    _stateController.add(initial);
    _eventController.stream.listen(_mapToHandlerEvent);
  }

  void _mapToHandlerEvent(CheckEvent event) async {
    if (event is RestoreAllCheckEvent) {
      _stateController.add(CheckLoadingState());
      await Future.delayed(Duration(milliseconds: 250));
      _checks = [
        Check(
            complete: false,
            name: 'shops',
            content: '',
            readeable: "Default text for your note task from 'shops'",
            createDate: DateTime.now(),
            updateDate: DateTime.now()),
      ];
      _stateController.add(CheckLoadedState(tasks: _checks));
    } else if (event is SaveAllCheckEvent) {
    } else if (event is SearchCheckEvent) {
    }

    //crud
    else if (event is AddCheckEvent) {
    } else if (event is UpdateCheckEvent) {
    } else if (event is DeleteCheckEvent) {
    }

    //for several selections
    else if (event is DeleteSeveralCheckEvent) {}
  }
}
