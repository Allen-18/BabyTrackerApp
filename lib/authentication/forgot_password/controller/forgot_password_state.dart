part of 'forgot_password_controller.dart';

class ForgotPasswordState extends Equatable {
  final Email email;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        email,
        status,
      ];
}
