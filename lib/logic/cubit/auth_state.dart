part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {} //show authentication screen

class SplashState extends AuthState {} //show splash screen

class EmailVerifiedState extends AuthState {
  //show products screen OR Email Verification screen depending on isverified
  final bool isverified;
  EmailVerifiedState({
    this.isverified = false,
  });
}

class InternetConnectionFailed extends AuthState {
} //show snack bar in the main listener

class AuthLoadingState extends AuthState {
} //show circle progress indicator in stack of auth screen

//class AuthLoadingSuccessState extends AuthState {}

class SnackBarAuthLoadingFailedState extends AuthState {
  //show alert dialog using listener in auth screen
  //show alert dialog using main listener
  //show snack bar using listener in settings screen
  final String error;
  SnackBarAuthLoadingFailedState({
    required this.error,
  });
}

class AlertDialogAuthLoadingFailedState extends AuthState {
  final String error;
  AlertDialogAuthLoadingFailedState({
    required this.error,
  });
}

class SnackBarVerificationFailedState extends AuthState {
  //show alert dialog using listener in auth screen
  //show alert dialog using main listener
  //show snack bar using listener in settings screen
  final String error;
  SnackBarVerificationFailedState({
    required this.error,
  });
}

class AlertDialogVerificationFailedState extends AuthState {
  final String error;
  AlertDialogVerificationFailedState({
    required this.error,
  });
}

//flasg inside auth screen
class AuthModeState extends AuthState {
  final AuthMode authmode;
  AuthModeState({
    required this.authmode,
  });
}

//flasg inside auth screen
class HidePassState extends AuthState {
  final bool hidePass;
  HidePassState({
    required this.hidePass,
  });
}

class PasswordResetSuccessfully extends AuthState {
  final bool resetSuccess;
  PasswordResetSuccessfully({
    required this.resetSuccess,
  });
}

class PasswordResetLoading extends AuthState {
  final bool isPasswordLoading;
  PasswordResetLoading({
    this.isPasswordLoading = false,
  });
}

class GettingUserData extends AuthState {}

class GettingUserDataDone extends AuthState {}

class GettingUserDataFailed extends AuthState {
  final String exception;
  GettingUserDataFailed({
    required this.exception,
  });
}

class LocalGenderChanged extends AuthState {
  final String gender;
  LocalGenderChanged({
    required this.gender,
  });
}

class LocalCityChanged extends AuthState {
  final String city;
  LocalCityChanged({
    required this.city,
  });
}

class LocalDateChanged extends AuthState {
  final DateTime date;
  LocalDateChanged({
    required this.date,
  });
}

class UserDataScreenInitState extends AuthState {}

class UserDataScreenLoadingState extends AuthState {}

class UserDataScreenDoneState extends AuthState {}

class UserDataScreenErrorState extends AuthState {
  final String exception;
  UserDataScreenErrorState({
    required this.exception,
  });
}
