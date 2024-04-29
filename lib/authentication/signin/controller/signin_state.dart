part of 'signin_controller.dart';

class SignInState extends Equatable {
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  SignInState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? buttonTapped,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        status,
      ];
}
