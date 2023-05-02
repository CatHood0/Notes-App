import 'package:notes_project/domain/entities/User.dart';
import 'package:notes_project/domain/repository/account/IAccountRepo.dart';

class AccountRepository implements IAccountRepo{
  @override
  Future<String> authenticationWithEmailAndPass({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<String> authenticationWithFacebook({required credentials}) {
    throw UnimplementedError();
  }

  @override
  Future<String> authenticationWithGoogle({required credentials}) {
    throw UnimplementedError();
  }

  @override
  Future<int> create({required User obj}) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required int idObj}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update({required User obj}) {
    throw UnimplementedError();
  }

}