import 'package:notes_project/interface/ICrud.dart';
import 'package:notes_project/interface/ISearch.dart';
import '../../entities/Note.dart';

abstract class INoteRepository implements ICrud<note>, ISearch<note>{
  Stream<List<note>> getAllNotes({required String idAccount});
  Stream<List<note>> syncronizeData({required String idAccount}); 
}
