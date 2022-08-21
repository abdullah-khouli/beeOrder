import 'dart:math';
import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/password_reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/enums.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                    const Color.fromRGBO(215, 188, 117, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, 1],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (deviceSize.height < 500)
                      SizedBox(
                        height: deviceSize.height / 4,
                      ),
                    Container(
                      alignment: Alignment.center,
                      width: deviceSize.width,
                      margin: const EdgeInsets.only(bottom: 20, left: 10),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Bee Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? (deviceSize.width / 12)
                              : (deviceSize.width / 8), //50,
                          fontFamily: 'Anton',
                        ),
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.shade900,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, 2))
                          ]),
                    ),
                    const AuthCard(),
                  ],
                ),
              ),
            ),
            if (state is AuthLoadingState)
              ModalBarrier(
                color: Colors.black.withOpacity(0.3),
                dismissible: false,
                barrierSemanticsDismissible: false,
              ),
            if (state is AuthLoadingState)
              const Center(child: CircularProgressIndicator()),
          ],
        )),
      ),
      buildWhen: (previous, current) =>
          (current is AuthLoadingState || current is AuthInitialState),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);
  // final BuildContext ctx;
  @override
  _AuthCardState createState() => _AuthCardState();
}

//enum AuthMode { Login, SignUp }

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {'email': '', 'password': ''};
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _submit(AuthMode authMode) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    await BlocProvider.of<AuthCubit>(context).tryAuth(_authData, authMode);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: deviceSize.width * 0.85,
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AlertDialogAuthLoadingFailedState) {
                  print('herehereherejjjjjjjjjjj');
                  print(state.error);
                  AlertDialog editAlert1 = AlertDialog(
                      title: Text(state.error.split('|')[0]),
                      content: Builder(
                        builder: (ctx) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(state.error.split('|')[1]),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      /* BlocProvider.of<AuthCubit>(context)
                                          .removeError();*/

                                      Navigator.of(ctx).pop();
                                      //  SystemNavigator.pop();
                                    },
                                    child: const Text('ok')),
                              )
                            ],
                          );
                        },
                      ));
                  showDialog(
                      context: context,
                      builder: (context) => editAlert1,
                      barrierDismissible: false);
                } else if (state is InternetConnectionFailed) {
                  print('llllllllllllllll');
                  const snackBar = SnackBar(
                    content: Text('No internet connection'),
                  );
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              listenWhen: (previous, current) =>
                  (current is AlertDialogAuthLoadingFailedState ||
                      current is InternetConnectionFailed),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: const ValueKey('email'),
                    onSaved: (val) {
                      _authData['email'] = val!.trim();
                    },
                    validator: (val) {
                      if (val!.trim().isEmpty || !val.contains('@')) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: "Enter Your Email Address",
                        suffixIcon: Icon(Icons.mail),
                        labelText: 'Email'),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) => current is HidePassState,
                    builder: (context, state) {
                      final hidePass =
                          (state is HidePassState && state.hidePass)
                              ? true
                              : false;
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: !hidePass,
                        onSaved: (val) {
                          _authData['password'] = val!.trim();
                        },
                        validator: (val) {
                          if (val!.trim().isEmpty || val.trim().length < 5) {
                            return 'password must be at least 5 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Your password",
                            suffixIcon: IconButton(
                              icon: (!hidePass)
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .switchHidePass(hidePass);
                              },
                            ),
                            labelText: 'password'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) => current is AuthModeState,
                    builder: (context, state) {
                      final authMode = (state is AuthModeState &&
                              state.authmode == AuthMode.SignUp)
                          ? AuthMode.SignUp
                          : AuthMode.Login;
                      return Column(
                        children: [
                          if (authMode == AuthMode.SignUp)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              constraints: BoxConstraints(
                                minHeight: authMode == AuthMode.SignUp ? 60 : 0,
                                maxHeight:
                                    authMode == AuthMode.SignUp ? 120 : 0,
                              ),
                              curve: Curves.easeIn,
                              child: SlideTransition(
                                position: _slideAnimation,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: BlocBuilder<AuthCubit, AuthState>(
                                    buildWhen: (previous, current) =>
                                        current is HidePassState,
                                    builder: (context, state) {
                                      final hidePass =
                                          (state is HidePassState &&
                                                  state.hidePass)
                                              ? true
                                              : false;

                                      return TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Confirm password',
                                          hintText: "Confirm Your password",
                                          suffixIcon: IconButton(
                                            icon: authMode == AuthMode.SignUp
                                                ? (hidePass == false
                                                    ? const Icon(
                                                        Icons.visibility)
                                                    : const Icon(
                                                        Icons.visibility_off))
                                                : Container(),
                                            onPressed: () =>
                                                BlocProvider.of<AuthCubit>(
                                                        context)
                                                    .switchHidePass(hidePass),
                                          ),
                                        ),
                                        obscureText: !hidePass,
                                        validator: authMode == AuthMode.SignUp
                                            ? (val) {
                                                if (val !=
                                                    _passwordController.text) {
                                                  return 'password do not match!';
                                                }
                                                return null;
                                              }
                                            : null,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await _submit(authMode);
                            },
                            child: Text((state is AuthModeState &&
                                    state.authmode == AuthMode.SignUp)
                                ? 'SignUp'
                                : 'Login'),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              textStyle: MaterialStateProperty.all(
                                TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6!
                                        .color),
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                              ),
                            ),
                          ),
                          if (authMode == AuthMode.Login)
                            TextButton(
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PasswordReset(),
                                    ),
                                  );
                                },
                                child: const Text('Forgot Password')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              (authMode == AuthMode.SignUp)
                                  ? const Text('Already have an account ?')
                                  : const Text('don\'t have an account ?'),
                              TextButton(
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6!
                                            .color),
                                  ),
                                ),
                                onPressed: /* state.isloading == true
                              ? null
                              :*/
                                    () => BlocProvider.of<AuthCubit>(context)
                                        .switchAuthMode(authMode),
                                child: Text(
                                    '${(authMode == AuthMode.SignUp) ? 'Login' : 'SignUp'} Instead'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
