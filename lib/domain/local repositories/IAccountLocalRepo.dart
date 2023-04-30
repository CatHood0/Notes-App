import 'package:notes_project/domain/entities/User.dart';
import 'package:notes_project/domain/interface/ICrud.dart';

abstract class IAccountLocalRepository implements ICrud<User>{
  Future<void> openDatabase(); 
  Future<User> getUser();
}