import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/entities/Template.dart';
import 'package:notes_project/domain/interface/ISearch.dart';
import '../../interface/ICrudLocal.dart';

abstract class IStoreLocalRepository implements ICrudLocal<Template>, ISearch<Template>{
  StreamStoreEither getAllTemplates();
  Future<void> saveAllTemplatesFromDb({required List<Template> templates});
  Future<void> openDatabase(); 
}