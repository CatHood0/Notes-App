
import '../model/Note.dart';

class noteController{

  static int? idNote;
  static note? Notes;
  static List<int> ids = [];//this for that the user can delete some files the same time
  static List<note> _listaNotas = [
    note("Hola", "Contenido", DateTime.now(), 0, true),//this can nullable if is: [];
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

  //ahora hay que crear metodos para recorrer y encontrar lo que quermeos,
  //de todas formas, recuerda que List se puede recorrer como un array comun y corriente
  //a pesar de que parezca una puta coleccion


  /*Haremos algo super sencillo, para poder mandar la informacion a otra ventana donde la visualicemos
  lo que haremos es que, apenas se toque el dicho customCard, se cree un objeto de tipo note, y llamemos 
  a la otra pagina, a la cual debemos pasarle ese objeto note, y con ese mismo estructuraremos la informacion
  dentro de esa pagina. De esa forma, no tendremos complicaciones al encontrar la informacion, ya que la misma
  se tomara del customCard, hacia la note y de alli lo demas es facil

  para la ediciond de la misma, lo que haremos es que se tome como paremos tambien el id de dicha card
  y que cuando se actualice, se envien los nuevos datos a la lista (borrando la que tenia el id, y añadiendo la nueva) con insert
  De esta forma, todo sera mas sencillo
  
  */

}