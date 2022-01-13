import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mecarassignment/model/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.userList) : super(const LoginState()) {
    on<LoginSubmmited>(_onLoginSubmmited);
    on<LoginErrorPressed>(_onLoginErrorPresed);
  }

  final List<User> userList;
  void _onLoginSubmmited(
    LoginSubmmited event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: LoginStatus.submitting));
      final String username = event.username;
      final String password = event.password;
      final loginUser = User(username, password);

      if (userList.any((user) =>
          user.username == loginUser.username &&
          user.password == loginUser.password)) {
        emit(
          state.copyWith(
            status: LoginStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.failed,
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: LoginStatus.failed,
        ),
      );
    }
  }

  void _onLoginErrorPresed(
    LoginErrorPressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(status: LoginStatus.initial, errorMessage: ''));
    } catch (e) {
      log(e.toString());
    }
  }
}
