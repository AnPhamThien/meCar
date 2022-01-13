import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mecarassignment/model/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginSubmmited>(_onLoginSubmmited);
  }

  void _onLoginSubmmited(
    LoginSubmmited event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: LoginStatus.submitting,
        ),
      );
      final String username = event.username;
      final String password = event.password;
      final User user = User();
      final List<User> userList = user.userList;
      if (userList.contains(User(username: username, password: password))) {
        emit(
          state.copyWith(
            status: LoginStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
              status: LoginStatus.failed,
              errorMessage: "Wrong username or password"),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.failed,
            errorMessage: "Wrong username or password"),
      );
    }
  }
}
