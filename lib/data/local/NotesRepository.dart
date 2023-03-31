
import '../../domain/entities/Note.dart';

class NoteRepository{

  static int? idNote;
  static note? Notes;
  static List<int> ids = [];//this for that the user can delete some files the same time
  static List<note> _listaNotas = [
    note(title: "Hola", content: "Contenido", createDate: DateTime.now(), key: 0, favorite: true, dateTimeModification: DateTime.now()),//this can nullable if is: [];
  ];

  static List<note> _listAllNotes = _listaNotas;


  static void getIdCard(note Note){
      idNote = Note.Key;
      Notes = Note;
  }

  static List<note> getList(String? search){//hay que probar esto
    if(search!=""){
       for(int i=0; i<_listaNotas.length;i++){
            if(_listaNotas[i].Title==search){
              _listaNotas.removeWhere((search) => _listaNotas[i].Title!=search);
               return _listaNotas;
            }
       }
    }
     return _listaNotas;
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