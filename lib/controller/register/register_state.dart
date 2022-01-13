part of 'register_bloc.dart';

enum RegisterStatus { initial, submitting, success, userexist, failed }

class RegisterState extends Equatable {
  const RegisterState(
      {this.status = RegisterStatus.initial, this.errorMessage = ''});

  final RegisterStatus status;
  final String errorMessage;

  RegisterState copyWith({RegisterStatus? status, String? errorMessage}) {
    return RegisterState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [status, errorMessage];
}
