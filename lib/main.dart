import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/home_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/market_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/product_overview_cubit.dart';
import 'package:beeorder_bloc/logic/cubit/restaurant_cubit.dart';
import 'package:beeorder_bloc/presentation/screens/email_verification.dart';
import 'package:beeorder_bloc/presentation/screens/splash_screen.dart';
import 'package:beeorder_bloc/presentation/screens/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/colors.dart';
import 'data/data_providers/database.dart';
import 'logic/cubit/cart_cubit.dart';
import 'logic/cubit/email_verification_cubit.dart';
import 'logic/cubit/product_details_cubit.dart';
import 'logic/cubit/profile_cubit.dart';
import 'logic/cubit/restaurant_favorite_cubit.dart';
import 'presentation/screens/auth_screen.dart';
import 'presentation/screens/product_overview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(
    /* MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => AuthCubit(),
            child: BlocProvider<RestaurantCubit>(
              create: (context) =>
                  RestaurantCubit(BlocProvider.of<AuthCubit>(context)),
              child: const MyApp(),
            )),
        BlocProvider<MarketCubit>(
          create: (context) => MarketCubit(BlocProvider.of<AuthCubit>(context)),
        ),
      ],
      child: const MyApp(),
    ),*/
    BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RestaurantCubit>(
            create: (context) =>
                RestaurantCubit(BlocProvider.of<AuthCubit>(context)),
          ),
          BlocProvider<MarketCubit>(
            create: (context) => MarketCubit(
              BlocProvider.of<AuthCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => HomeCubit(
              BlocProvider.of<AuthCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => RestaurantFavoriteCubit(
              BlocProvider.of<AuthCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ProductDetailsCubit(
              BlocProvider.of<AuthCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
              BlocProvider.of<AuthCubit>(context),
            ),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('myapp');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Color(0XFFE06D00),
        ),
        splashColor: const Color(0XFFE06D00),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
        ),
        primaryColor: const Color(0XFFE06D00),
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: MaterialColor(0XFFE06D00, color))
            .copyWith(secondary: const Color(0XFFE06D00)),
      ),
      home: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is InternetConnectionFailed) {
            print('hjhjhjhj');
            const snackBar = SnackBar(
              content: Text('No internet connection'),
            );
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is AlertDialogVerificationFailedState) {
            AlertDialog editAlert1 = AlertDialog(
                title: Text(state.error.split('|')[0]),
                content: Builder(
                  builder: (ctx) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.error.split('|')[1],
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(ctx).pop();

                                await SystemNavigator.pop(animated: true);
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
          }
        },
        listenWhen: (previous, current) =>
            (current is InternetConnectionFailed ||
                current is AlertDialogVerificationFailedState),
        buildWhen: (previous, current) => (current is SplashScreen ||
            current is EmailVerifiedState ||
            current is AuthInitialState ||
            current is UserDataScreenInitState ||
            current is UserDataScreenDoneState),
        builder: (ctx, state) {
          if (state is SplashState) {
            print('splash s');
            BlocProvider.of<AuthCubit>(context).autoAuth();
            return const SplashScreen();
            //  } else if (state is EmailVerifiedState && state.isverified) {
          } else if (state is UserDataScreenDoneState) {
            print('product s');
            return BlocProvider<ProductOverviewCubit>(
              create: (context) => ProductOverviewCubit(),
              child: const ProductOverviewscreen(),
            );
          } else if (state is EmailVerifiedState && !state.isverified) {
            print('verification s');
            return BlocProvider<EmailVerificationCubit>(
              child: const EmailVerification(),
              create: (context) =>
                  EmailVerificationCubit(BlocProvider.of<AuthCubit>(context)),
            );
          } else if (state is UserDataScreenInitState) {
            // } else if (state is EmailVerifiedState && state.isverified) {
            return const UserDataScreen();
          } else {
            print('auth s');
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
