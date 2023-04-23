import 'package:notes_project/domain/entities/Template.dart';
import 'package:notes_project/domain/repository/store/IStoreRepo.dart';

class StoreRepository implements IStoreRepository{
  @override
  Stream<void> changeVisibilityTemplate({required int idAccount, required Template tmp}) {
    throw UnimplementedError();
  }

  @override
  Future<void> create({required Template obj}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String idObj}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Template>> getAllTemplates({required int idAccount}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Template>> search({required String text}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update({required Template obj}) {
    throw UnimplementedError();
  }

}