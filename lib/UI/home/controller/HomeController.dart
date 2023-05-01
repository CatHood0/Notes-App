import '../../../db helper/db_helper.dart';
import '../../../domain/entities/Note.dart';

class HomeController{

  final NoteDao db;

  HomeController({required this.db}){
    db.openDb();
  } 

  void updateLocalNote(Note note)async{
    db.update(note);
  }

  Future<int> insertLocalNote(Note note)async{
    return db.insert(note);
  }

}