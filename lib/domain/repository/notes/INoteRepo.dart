import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/interface/ICrud.dart';
import 'package:notes_project/domain/interface/ISearch.dart';
import '../../entities/Note.dart';

abstract class INoteRepository implements ICrud<Note>, ISearch<Note>{
  StreamNoteEither getAllNotes({required String idAccount});
  StreamNoteEither syncronizeData({required String idAccount}); 
}
