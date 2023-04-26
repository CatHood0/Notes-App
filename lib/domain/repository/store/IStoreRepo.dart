import 'package:http/http.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/interface/ICrud.dart';

import '../../entities/Template.dart';
import '../../interface/ISearch.dart';

abstract class IStoreRepository implements ICrud<Template>, ISearch<Template> {
  StreamNoteEither getAllTemplates({required int idAccount});
  Stream<void> changeVisibilityTemplate(
      {required int idAccount, required Template tmp});
  Future<void> addLikeTemplate({required Template template});
  Future<void> dislikeTemplate({required Template template});
  Future<void> shareTemplate({required Template template});
}
