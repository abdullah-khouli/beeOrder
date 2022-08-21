part of 'email_verification_cubit.dart';

@immutable
abstract class EmailVerificationState {}

class EmailVerificationInitial extends EmailVerificationState {} //not verified

class EmailVerficationFailed extends EmailVerificationState {}

class EnableResend extends EmailVerificationState {}

class DisableResend extends EmailVerificationState {}

class EmailVerificationSendSuccess extends EmailVerificationState {}

class EmailVerificationSendFailed extends EmailVerificationState {
  final String error;
  EmailVerificationSendFailed({
    required this.error,
  });
}

class UserDeletedSuccess extends EmailVerificationState {
  final bool isDeleted;
  UserDeletedSuccess({
    required this.isDeleted,
  });
}

class EnableResendCounter extends EmailVerificationState {
  final int counterValue;
  EnableResendCounter({
    required this.counterValue,
  });
}
