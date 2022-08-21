import 'dart:async';

import 'package:beeorder_bloc/constants/enums.dart';
import 'package:beeorder_bloc/data/repository/authRep.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(SplashState());
  AuthRep authRep = AuthRep();
  Timer? timer;
  addUserProfileData(String userName, String gender, String city) async {
    emit(UserDataScreenLoadingState());
    print('addUserProfileData');
    final isConnected = await authRep.testInternetConnetion();
    if (isConnected) {
      final isDone = await authRep.repAddUserProfileData();
      if (isDone) {
        emit(UserDataScreenDoneState());
      } else {
        // emit(UserDataScreenInitState());
        emit(UserDataScreenErrorState(exception: 'Some thimg went wrong'));
      }
    } else {
      emit(InternetConnectionFailed());
      print('emited');
    }
  }

  localEditGender(String gender) {
    authRep.gender = gender;
    emit(LocalGenderChanged(gender: gender));
  }

  localEditDate(DateTime date) {
    authRep.date = date;
    emit(LocalDateChanged(date: date));
  }

  localEditCity(String city) {
    authRep.city = city;
    emit(LocalCityChanged(city: city));
  }

  editUserProfileData() async {
    emit(GettingUserData());
    print('addUserProfileData');
    final isConnected = await authRep.testInternetConnetion();
    if (isConnected) {
      final isDone = await authRep.repAddUserProfileData();
      if (isDone) {
        emit(GettingUserDataDone());
      } else {
        // emit(UserDataScreenInitState());
        emit(
          GettingUserDataFailed(
              exception: 'Some thing went wrong ,please check your connection'),
        );
      }
    } else {
      emit(
        GettingUserDataFailed(
            exception: 'Some thing went wrong ,please check your connection'),
      );
      print('emited');
    }
  }

  getUserProfileData() async {
    emit(GettingUserData());
    //emit(UserDataScreenLoadingState());
    print('getUserProfileData');
    final isConnected = await authRep.testInternetConnetion();
    if (isConnected) {
      final isDone = await authRep.repGetUserProfileData();
      if (isDone) {
        emit(GettingUserDataDone());
        // emit(GettingUserDataDone());
        print('done');
      } else {
        emit(
          GettingUserDataFailed(
              exception: 'Some thing went wrong ,please check your connection'),
        );
        print('failed');
        /* emit(UserDataScreenErrorState(
            exception: 'Some thing went wrong ,please check your connection'));*/
      }
    } else {
      //emit(InternetConnectionFailed());
      /* emit(UserDataScreenErrorState(
          exception: 'Some thing went wrong ,please check your connection'));*/
      emit(
        GettingUserDataFailed(
            exception: 'Some thing went wrong ,please check your connection'),
      );

      print('emited');
    }
    print(
        'doooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooone');
  }

  void switchAuthMode(AuthMode authmode) {
    if (authmode == AuthMode.Login) {
      emit(AuthModeState(authmode: AuthMode.SignUp));
    } else {
      emit(AuthModeState(authmode: AuthMode.Login));
    }
  }

  switchHidePass(bool currentValue) {
    print('current value is $currentValue');
    // print(state.myError);
    emit(HidePassState(
      hidePass: !currentValue,
    ));
  }

  /*removeError() {
    //state.myError = null;
    emit(AuthInitialState());
  }*/

  autoAuth() async {
    print('autoauth');
    final isConnected = await authRep.testInternetConnetion();
    if (isConnected) {
      final isAuth = await authRep.autoLogin();
      if (isAuth) {
        print('if');
        final isver = await isVerified(false);
        if (isver != null) {
          if (isver.contains('Invalid')) {
            print('invalid');
            logout();
            //emit(AuthInitialState());
          } else {
            emit(AlertDialogVerificationFailedState(error: isver));
          }
        }
      } else {
        print('else');
        emit(AuthInitialState());
      }
    } else {
      emit(InternetConnectionFailed());
      print('emited');
      timer = Timer(const Duration(seconds: 8), autoAuth);
    }
  }

  tryAuth(Map authData, AuthMode authmode) async {
    emit(AuthLoadingState());
    final isConnected = await authRep.testInternetConnetion();
    if (isConnected) {
      print('connected');
      final error = (authmode == AuthMode.Login)
          ? await authRep.repauth(
              sign: 'sign',
              email: authData['email']!,
              password: authData['password']!)
          : await authRep.repauth(
              sign: 'signUp',
              email: authData['email']!,
              password: authData['password']!);
      if (error != null) {
        print(error);
        emit(AuthInitialState());
        print('error');
        emit(AlertDialogAuthLoadingFailedState(error: error));
      } else if (authRep.idToken != '') {
        print('token true');
        await isVerified(authmode == AuthMode.SignUp);
      }
    } else {
      emit(AuthInitialState());
      emit(InternetConnectionFailed());
    }
  }

  resetPassword(String email) async {
    final isConnected = await authRep.testInternetConnetion();
    print('isconnected=$isConnected');
    if (isConnected) {
      emit(PasswordResetLoading(isPasswordLoading: true));
      final isReset = await authRep.resetPassword(email);
      print('isreset$isReset');
      if (isReset == null) {
        print('null');
        emit(PasswordResetSuccessfully(resetSuccess: true));
      } else {
        print('not nullll');
        emit(PasswordResetSuccessfully(resetSuccess: false));
      }
    } else {
      emit(InternetConnectionFailed());
    }
  }

  logout() async {
    bool signedOut = await authRep.signOut();

    if (signedOut) {
      print('sign out true');
      emit(AuthInitialState());
    } else {
      print('sign out false');

      emit(SnackBarAuthLoadingFailedState(
          error: 'failed|Please try again later'));
    }
  }

  Future<String?> isVerified(bool isSignUp) async {
    final isConnected = await authRep.testInternetConnetion();
    if (isConnected) {
      try {
        final emailVer = await authRep
            .repConfirmEmailVerification(); //if threw exception we show snack bar in main listener
        if (emailVer) {
          print('verified true');
          if (isSignUp) {
            emit(UserDataScreenInitState()); //to go to user data screen
          } else {
            emit(UserDataScreenDoneState()); //to go to product overview screen
          }
          return null;
        } else {
          print('verified false');
          emit(EmailVerifiedState(isverified: false));
          return null;
        }
      } catch (e) {
        print('verified null');
        print('catch');
        print(e);
        return e.toString();
      }
    } else {
      emit(InternetConnectionFailed());
    }
  }

  @override
  Future<void> close() {
    print('close');
    if (timer != null) {
      timer!.cancel();
    }
    return super.close();
  }
}
