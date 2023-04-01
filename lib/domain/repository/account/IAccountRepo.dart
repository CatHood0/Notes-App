import 'package:notes_project/domain/entities/User.dart';
import '../../../interface/ICrud.dart';

abstract class IAccountRepo implements ICrud<User> {
  Future<User> getUserFromToken(String token);
}
