part of 'checkBloc.dart';

abstract class CheckState {}

class CheckInitialState extends CheckState {
  final List<Check> list = [];
}

class CheckLoadingState extends CheckState{}

class CheckLoadedState extends CheckState{
  final List<Check> tasks;
  CheckLoadedState({required this.tasks});
}

class CheckAllCompleteState extends CheckState{
  final List<Check> completeList;
  CheckAllCompleteState({required this.completeList});
}

class CheckNotFoundState extends CheckState{
  final String message = 'Check not found. Please, try again with other text';
}

class CheckErrorState extends CheckState{
  final String onError = "A error has ocurred. If it continue displaying when you trying make something, report it";
}

