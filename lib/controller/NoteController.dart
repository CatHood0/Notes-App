
import '../model/Note.dart';

class noteController{

  static int? idNote;
  static note? Notes;
  static List<int> ids = [];//this for that the user can delete some files the same time
  static List<note> _listaNotas = [
    note("Hola", "Contenido", DateTime.now(), 0, true, DateTime.now()),//this can nullable if is: [];
  ];

  static void getIdCard(note Note){
      idNote = Note.getId();
      Notes = Note;
  }

  static List<note> getList(String? search){
      if(search != null){
        for(int i=0; i<_listaNotas.length;i++){
          if(_listaNotas[i].getTitle()==search){
              return _listaNotas;
          }
        }
      }
     return _listaNotas;
  }

  static void setFavorite(int index, bool state){
      _listaNotas[index].setFavorite(state);
  }

  static void setUpdateNote(int index, note Note){
      _listaNotas[index].setTitle(Note.getTitle());
      _listaNotas[index].setContent(Note.getContent());
      _listaNotas[index].setDateModification(DateTime.now());
  }

  static void removeNote(int index){
      _listaNotas.removeAt(index);
  }
  
  static bool isSearch(String? search){
    if(search != null){
         return true;
      }
     return false;
  }

  static void addCustomCard(note Note){
    _listaNotas.insert(0, Note);
    print(_listaNotas.length);
  }

}