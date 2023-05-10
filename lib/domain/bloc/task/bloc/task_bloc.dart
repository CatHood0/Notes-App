import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_project/domain/entities/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskEvent>((event, emit) {
      if(event is addTask){
        
      }
    });
  }
}
