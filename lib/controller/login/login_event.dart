part of 'login_bloc.dart';

class LoginEvent {}

class LoginSubmmited extends LoginEvent {
  final String username;
  final String password;

  LoginSubmmited(this.username, this.password);
}
