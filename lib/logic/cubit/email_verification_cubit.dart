import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  AuthCubit auth = AuthCubit();
  Timer? timer1;
  Timer? timer2;
  //Timer? timer3;
  EmailVerificationCubit(
    this.auth,
  ) : super(EmailVerificationInitial());

  startEnableResendCounter() async {
    print('start');
    for (int i = 45; i >= 0; i--) {
      print(i);
      emit(EnableResendCounter(counterValue: i));
      await Future.delayed(const Duration(seconds: 1));
    }
    print('counter finished');
    emit(EnableResend());
  }

  sendEmailVerification() async {
    final isConnected = await auth.authRep.testInternetConnetion();

    if (isConnected) {
      emit(DisableResend());
      startEnableResendCounter();
      try {
        final isSent = await auth.authRep.repSendEmailVerifiction();
        if (isSent == null) {
          emit(EmailVerificationSendSuccess());
        } else {
          if (isSent.contains('TOKEN') || isSent.contains('FOUND')) {
            //remove id token and go to auth screen
            await auth.logout();
          }
        }
      } catch (e) {
        emit(EmailVerificationSendFailed(error: e.toString()));
        auth.emit(SplashState());
      }
    } else {
      auth.emit(InternetConnectionFailed());
    }
  }

  logout() async {
    await auth.logout();
  }

  confirmEmailVerification() async {
    print('hhhhhhhh');
    final isver = await auth.isVerified(true);
    if (isver == null) {
      timer1 = Timer(const Duration(seconds: 3),
          () async => await confirmEmailVerification());
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('verification cubit error');
    super.onError(error, stackTrace);
  }

  @override
  Future<void> close() {
    print('close');
    if (timer1 != null) {
      timer1!.cancel();
    }

    if (timer2 != null) {
      timer2!.cancel();
    }
    //timer3!.cancel();
    return super.close();
  }
}
