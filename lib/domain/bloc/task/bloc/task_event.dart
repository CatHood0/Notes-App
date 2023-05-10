part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class DeleteTask{
  final int index;
  final int id;
  DeleteTask({required this.index, required this.id});
}

class addTask{
  final Task task;
  addTask({required this.task});
}

class updateTask{
  final Task task;
  final int index;
  updateTask({required this.task, required this.index});
}


