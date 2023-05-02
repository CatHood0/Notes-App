import '../../../domain/entities/Note.dart';
import '../../../domain/local repositories/note/INoteLocalRepo.dart';

class HomeController{

  final INoteLocalRepository db;

  HomeController({required this.db}){
    db.openDatabase();
  } 

  void updateLocalNote({required Note note})async{
    db.update(obj:note);
  }

  Future<int> insertLocalNote({required Note note})async{
    return db.create(obj:note);
  }

  void deleteLocalNote({required int id}){
    db.delete(id: id);
  }

}