import 'package:beeorder_bloc/logic/cubit/email_verification_cubit.dart';
import 'package:beeorder_bloc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  /*Future<void> didChangeDependencies() async {
    print('did change dependencies');
    BlocProvider.of<EmailVerificationCubit>(context).enableResendEmailButton;
    super.didChangeDependencies();
  }*/

  @override
  void initState() {
    print('init');
    BlocProvider.of<EmailVerificationCubit>(context).sendEmailVerification();
    // BlocProvider.of<EmailVerificationCubit>(context).enableResendEmailButton;
    // BlocProvider.of<EmailVerificationCubit>(context).startEnableResendCounter();
    BlocProvider.of<EmailVerificationCubit>(context).confirmEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      /* listenWhen: (previous, current) {
        return current is EmailVerificationInitial;
      },*/
      listener: (context, state) async {
        if (state is UserDeletedSuccess && !state.isDeleted) {
          print('delete failed');
          const snackBar = SnackBar(
            content: Text('Email deleting failed'),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is UserDeletedSuccess && state.isDeleted) {
          print('push');
          await Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const MyApp()),
              (route) => false);
        }
        if (state is EmailVerificationInitial) {
          print('EmailVerificationInitial');
          /* await BlocProvider.of<EmailVerificationCubit>(context)
              .confirmEmailVerification();*/
        }
        if (state is EmailVerficationFailed) {
          const snackBar = SnackBar(
            content: Text('Connection failed, Email verification failed'),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is DisableResend) {
          print('DisableResend');
        }
        if (state is EnableResend) {
          print('EnableResend');
        }
        if (state is EmailVerificationSendSuccess) {
          print('Email verification has been sent successfuly');
          const snackBar = SnackBar(
            content: Text('Email verification has been sent successfuly'),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is EmailVerificationSendFailed) {
          print('EmailVerificationSendFailed');
          print(state.error);
          final snackBar = SnackBar(
            content: Text(state.error),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      // buildWhen: (previous, current) => current is EmailVerified,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/verEmail.png'))),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              child: const Text(
                  'A verification link has been sent to you Email .'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
                  /* buildWhen: (previous, current) =>
                      ((current is EnableResend) ||
                          (current is DisableResend) ||
                          (current is EnableResendCounter)),*/
                  builder: (context, state) {
                    return state is EnableResendCounter
                        ? Text('00:${state.counterValue.toString()}')
                        : const Text('00:00');
                  },
                  buildWhen: (previous, current) =>
                      current is EnableResendCounter,
                ),
                const SizedBox(width: 15),
                BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
                  buildWhen: (previous, current) =>
                      ((current is EnableResend) || (current is DisableResend)),
                  builder: (context, state) {
                    print('build111');
                    return ElevatedButton(
                      onPressed: (state is EnableResend)
                          ? () async {
                              await BlocProvider.of<EmailVerificationCubit>(
                                      context)
                                  .sendEmailVerification();
                            }
                          : null
                      /* await BlocProvider.of<EmailVerificationCubit>(
                                                              context)
                                                          .confirmEmailVerification();*/
                      ,
                      child: const Text('Resend Email'),
                    );
                  },
                ),
              ],
            ),
            /* BlocListener<EmailVerificationCubit, EmailVerificationState>(
                 listener: (context, state) => ,
                  child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state is EnableResendCounter
                            ? Text('00:${state.counterValue.toString()}')
                            : const Text('00:00'),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: (state is EnableResend)
                              ? () async {
                                  await BlocProvider.of<EmailVerificationCubit>(
                                          context)
                                      .sendEmailVerification();
                                }
                              : null
                          /* await BlocProvider.of<EmailVerificationCubit>(
                                          context)
                                      .confirmEmailVerification();*/
                          ,
                          child: const Text('Resend Email'),
                        ),
                      ],
                    )
                  ,
                ),
             */
            TextButton(
              onPressed: () async {
                await BlocProvider.of<EmailVerificationCubit>(context).logout();
              },
              child: const Text('change email address'),
            ),
          ],
        ),
      ),
    );
  }
}
