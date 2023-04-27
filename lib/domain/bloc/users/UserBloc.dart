import 'dart:async';

import 'package:notes_project/domain/bloc/users/UserEvents.dart';
import 'package:notes_project/domain/bloc/users/UserStates.dart';

import '../../entities/User.dart';

class UserBloc {
  User? _user = null;
  final _userStatesController = StreamController<UserStates>.broadcast();
  final _userStreamEvent = StreamController<UserEvent>();
  Stream<UserStates> get state => _userStatesController.stream;
  StreamSink<UserEvent> get eventSink => _userStreamEvent.sink;

  UserBloc() {
    _userStatesController.add(UserInitialState());
    _userStreamEvent.stream.listen(_mapToStateEvent);
  }

  void _mapToStateEvent(UserEvent event) {
    if (event is UserSignInEvent) {
      _userStatesController.add(UserLoadingState());
      _user = event.user;
      _userStatesController.add(UserLoggedState(user: _user!));
    } else if (event is UserSignUpEvent) {
      _userStatesController.add(UserLoadingState());
      _user = event.user;
      _userStatesController.add(UserLoggedState(user: _user!));
    } else if (event is UserSignOut) {
      _userStatesController.add(UserLoadingState());
      _user = null;
      _userStatesController.add(UserLoggedOutState());
    } else if (event is UserEmailChangedEvent) {
      _user = event.user;
      _userStatesController.add(UserLoggedState(user: _user!));
    } else if (event is UserPasswordChangedEvent) {
      _user = event.user;
      _userStatesController.add(UserLoggedState(user: _user!));
    } else if (event is UserUpdatedEvent) {
      _userStatesController.add(UserLoadingState());
      _user = event.user;
      _userStatesController.add(UserLoggedState(user: _user!));
    } else if (event is UserDeletedEvent) {
      _userStatesController.add(UserLoadingState());
      _user = null;
      _userStatesController.add(UserLoggedOutState());
    } else if (event is BanUserEvent) {
    } else if (event is DesbanUserEvent) {
    } else if (event is SearchUserEvent) {
    } else if(event is SignInFromCredentialsEvent){

    }
    
  }

  void dispose(){
    _userStatesController.close();
    _userStreamEvent.close();
  }

}
