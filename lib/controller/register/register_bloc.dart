import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mecarassignment/model/user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.userList) : super(const RegisterState()) {
    on<RegisterSubmmited>(_onRegisterSubmmited);
    on<RegisterErrorPressed>(_onRegsiterErrorPressed);
  }

  final List<User> userList;
  void _onRegisterSubmmited(
    RegisterSubmmited event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RegisterStatus.submitting));
      final String username = event.username;
      final String password = event.password;
      final registerUser = User(username, password);

      if (userList.any((user) => user.username == registerUser.username)) {
        emit(state.copyWith(
            status: RegisterStatus.userexist,
            errorMessage: "This account already exist"));
      } else {
        userList.add(registerUser);
        emit(
          state.copyWith(
            status: RegisterStatus.success,
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(
        state.copyWith(
          status: RegisterStatus.failed,
        ),
      );
    }
  }

  void _onRegsiterErrorPressed(
    RegisterErrorPressed event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RegisterStatus.initial, errorMessage: ''));
    } catch (e) {
      log(e.toString());
    }
  }
}
