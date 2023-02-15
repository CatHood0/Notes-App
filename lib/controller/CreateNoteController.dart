import 'package:notes_project/Widgets/CustomCard.dart';

class noteController{

  static List<customCard> listaNotas = List.empty();
  static String? titleReceive;
  static int? idCusCard;

  static void setIdCard(customCard card){
      idCusCard = card.getIdCard();
  }

  static customCard? getContent(){
      
      for(customCard card in listaNotas){
          if(card.getIdCard()==idCusCard){
              return card;
          }
      } 
      return null;
  }

  static void newNote(customCard card){
       listaNotas.add(card);
  }

  static void removeNote(int Idcard){
      for(customCard card in listaNotas){
          if(card.getIdCard()==Idcard){
            listaNotas.remove(card);
            break;
          }
      } 
  }

  static void updateNote(int idCard, String content, String title){
          for(customCard card in listaNotas){
                if(card.getIdCard()==idCard){
                    card.setContentCard(content);
                    card.setTitle(title);
                    break;
                }
          }
  }


}