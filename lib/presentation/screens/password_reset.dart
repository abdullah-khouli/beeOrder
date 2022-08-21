import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PasswordReset extends StatelessWidget {
  PasswordReset({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey(debugLabel: '');
  String _email = '';
  @override
  Widget build(BuildContext context) {
    print('build');
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) => current is PasswordResetSuccessfully,
      listener: (context, state) {
        print('listener');
        if (state is PasswordResetSuccessfully && state.resetSuccess) {
          AlertDialog editAlert = AlertDialog(
              title: const Text('Reset Password'),
              content: Builder(
                builder: (ctx) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('A Reset Link has been sent to your Email'),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('ok')),
                      )
                    ],
                  );
                },
              ));
          showDialog(
              context: context,
              builder: (context) => editAlert,
              barrierDismissible: false);
        } else if (state is PasswordResetSuccessfully && !state.resetSuccess) {
          AlertDialog editAlert = AlertDialog(
              title: const Text('Reset Password'),
              content: Builder(
                builder: (ctx) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                          'Some thing went wrong ,Please trya again later'),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('ok')),
                      )
                    ],
                  );
                },
              ));
          showDialog(
              context: context,
              builder: (context) => editAlert,
              barrierDismissible: false);
        }
      },
      buildWhen: (previous, current) => (current is PasswordResetLoading),
      builder: (context, state) {
        print('buildbuild');
        return SafeArea(
          child: Scaffold(
            body: Stack(fit: StackFit.expand, children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/verEmail.png'))),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                      child: Text(
                        'Enter your Email to send you a reset link',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: _key,
                        child: TextFormField(
                          onSaved: (newValue) => _email = newValue!,
                          validator: (val) {
                            print('validate');
                            if (val!.trim().isEmpty || !val.contains('@')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          //autofocus: true,
                          decoration: const InputDecoration(
                              hintText: "Enter Your Email Address",
                              suffixIcon: Icon(Icons.mail),
                              labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                                blurRadius: 2.0)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              const Color(0XFFE64B2D).withOpacity(0.9),
                              const Color(0XFFF87600).withOpacity(0.9),
                            ],
                          )),
                      height: size.height / 16 < 40 ? 40 : size.height / 16,
                      margin: const EdgeInsets.only(
                          left: 90, right: 90, top: 50, bottom: 15),
                      //  padding: const EdgeInsets.all(35.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.transparent,
                          ),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            _key.currentState!.save();
                            await BlocProvider.of<AuthCubit>(context)
                                .resetPassword(_email);
                          }
                        },
                        child: Container(
                          // color: Colors.amber,
                          padding: const EdgeInsets.only(bottom: 5),
                          height: size.height / 16 < 40 ? 40 : size.height / 16,
                          alignment: Alignment.center,
                          width: size.width * 0.8,
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              //    backgroundColor: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state is PasswordResetLoading && state.isPasswordLoading)
                ModalBarrier(
                  color: Colors.black.withOpacity(0.3),
                  dismissible: false,
                  barrierSemanticsDismissible: false,
                ),
              if (state is PasswordResetLoading && state.isPasswordLoading)
                const Center(child: CircularProgressIndicator()),
            ]),
          ),
        );
      },
    );
  }
}
