part of 'checkBloc.dart';

abstract class CheckEvent{}

class DeleteCheckEvent extends CheckEvent{
  final int index;
  final int id;
  DeleteCheckEvent({required this.index, required this.id});
}
class AddCheckEvent extends CheckEvent{
  final Check task;
  AddCheckEvent({required this.task});
}

class UpdateCheckEvent extends CheckEvent{
  final Check task;
  final int index;
  UpdateCheckEvent({required this.task, required this.index});
}

class RestoreAllCheckEvent extends CheckEvent{} 

class SaveAllCheckEvent extends CheckEvent{}

class SearchCheckEvent extends CheckEvent {
  final String search;
  SearchCheckEvent({
    required this.search,
  });
}

class DeleteSeveralCheckEvent extends CheckEvent {
  final List<int> index;
  final List<int> id;
  DeleteSeveralCheckEvent({
    required this.index,
    required this.id,
  });
}




