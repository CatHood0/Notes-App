import 'dart:ui';

import 'package:notes_project/domain/entities/User.dart';
import 'package:notes_project/domain/local%20repositories/IAccountLocalRepo.dart';
import 'package:notes_project/domain/repository/account/IAccountRepo.dart';

class AccountLocalRepository implements IAccountLocalRepository {
  @override
  Future<void> openDatabase() {
    throw UnimplementedError();
  }

  @override
  Future<User> getUser() {
    throw UnimplementedError();
  }

  //we must use the next methods, when the user has internet
  @override
  Future<void> create({required User obj}) {//for when SignIn or SignUp
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String idObj}) {//When SignOut
    throw UnimplementedError();
  }

  @override
  Future<void> update({required User obj}) {//When the user properties was changes and user has internet
    throw UnimplementedError();
  }
}