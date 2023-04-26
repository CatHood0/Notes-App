import '../../../enums.dart';
import '../../entities/User.dart';

abstract class UserEvent {}

class UserSignUpEvent extends UserEvent {
  final User user;
  UserSignUpEvent({required this.user});
}

class SearchUserEvent extends UserEvent {
  final String search;
  final User user;
  SearchUserEvent({required this.search, required this.user});
}

class UserSignInEvent extends UserEvent {
  final User user;
  UserSignInEvent({required this.user});
}

class UserSignOut extends UserEvent {
  final User user;
  UserSignOut({required this.user});
}

class UserDeletedEvent extends UserEvent {
  final User user;
  UserDeletedEvent({required this.user});
}

class UserUpdatedEvent extends UserEvent {
  final User user;
  UserUpdatedEvent({required this.user});
}

class DesbanUserEvent extends UserEvent {
  final String excuseMessage;
  final User user;
  DesbanUserEvent({required this.excuseMessage, required this.user});
}

class BanUserEvent extends UserEvent {
  final List<TypeBan> reasonBan;
  final String message;
  final User user;
  BanUserEvent({
    required this.reasonBan,
    required this.message,
    required this.user,
  });
}

class UserPasswordChangedEvent extends UserEvent {
  final User user;
  UserPasswordChangedEvent({required this.user});
}

class UserEmailChangedEvent extends UserEvent {
  final User user;
  UserEmailChangedEvent({required this.user});
}
