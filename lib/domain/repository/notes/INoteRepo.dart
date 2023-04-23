import 'package:notes_project/domain/interface/ICrud.dart';
import 'package:notes_project/domain/interface/ISearch.dart';
import '../../entities/Note.dart';

abstract class INoteRepository implements ICrud<note>, ISearch<note>{
  Stream<List<note>> getAllNotes({required String idAccount});
  Stream<List<note>> syncronizeData({required String idAccount}); 
}
