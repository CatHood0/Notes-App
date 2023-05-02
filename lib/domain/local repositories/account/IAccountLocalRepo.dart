import 'package:notes_project/domain/entities/User.dart';
import 'package:notes_project/domain/interface/ICrudLocal.dart';

abstract class IAccountLocalRepository implements ICrudLocal<User> {
  Future<void> openDatabase(); 
  Future<User> getUser();
}