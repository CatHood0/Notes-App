import 'package:notes_project/domain/entities/Template.dart';
import 'package:notes_project/constant.dart';
import 'package:notes_project/domain/local%20repositories/store/IStoreLocalRepo.dart';

class StoreLocalRepository implements IStoreLocalRepository {
  @override
  Future<void> openDatabase() {
    throw UnimplementedError();
  }

  @override
  Future<int> create({required Template obj}) {
    throw UnimplementedError();
  }

  @override
  StreamStoreEither getAllTemplates() {
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
  
  @override
  Future<void> saveAllTemplatesFromDb({required List<Template> templates}) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> delete({required int id}) {
    throw UnimplementedError();
  }
}
