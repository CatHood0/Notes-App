import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/interface/ICrud.dart';

import '../../entities/Template.dart';
import '../../interface/ISearch.dart';

abstract class IStoreRepository implements ICrud<Template>, ISearch<Template> {
  Stream<List<Template>> getAllTemplates({required int idAccount});
  Stream<void> changeVisibilityTemplate(
      {required int idAccount, required Template tmp});
  Stream<void> addLikeTemplate({required Template template});
  Stream<void> dislikeTemplate({required Template template});
  StreamStoreEither shareTemplate({required Template template});
}
