import 'package:notes_project/domain/entities/User.dart';
import 'package:notes_project/domain/interface/IAuth.dart';
import '../../interface/ICrud.dart';

abstract class IAccountRepo implements ICrud<User>, IAuth {
}
