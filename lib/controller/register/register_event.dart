part of 'register_bloc.dart';

class RegisterEvent {}

class RegisterSubmmited extends RegisterEvent {
  final String username;
  final String password;

  RegisterSubmmited(this.username, this.password);
}

class RegisterErrorPressed extends RegisterEvent {}
