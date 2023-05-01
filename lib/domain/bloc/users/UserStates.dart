import '../../enums/enums.dart';
import '../../entities/User.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoggedOutState extends UserStates {}

class UserLoggedState extends UserStates {
  final User user;
  UserLoggedState({required this.user});
}

class UserNotSynchronizedState extends UserStates {
  final User user;
  UserNotSynchronizedState({required this.user});
}

class UserNotFoundState extends UserStates {
  String error;
  UserNotFoundState({
    required this.error,
  });
}

class UserWillBanningOnTimeState extends UserStates {
  String banMessage;
  List<TypeBan> reasonBan;
  String idUser;
  UserWillBanningOnTimeState({
    required this.banMessage,
    required this.reasonBan,
    required this.idUser,
  });
}

class UserWasBannedState extends UserStates {
  final User user;
  final DateTime timeHasBanned;
  final List<TypeBan> reasonBan;
  UserWasBannedState({required this.user, required this.reasonBan, required this.timeHasBanned});
}

class UserInvalidPassword extends UserStates {
  String error;
  UserInvalidPassword({
    required this.error,
  });
}

class UserInvalidEmail extends UserStates {
  String error;
  UserInvalidEmail({
    required this.error,
  });
}

class UserInvalidUsername extends UserStates {
  String error;
  UserInvalidUsername({
    required this.error,
  });
}
