import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  List<String> city = [
    'Damascus',
    'Aleppo',
    'Latakia',
    'Tartus',
    'Homs',
    'Hama'
  ];

  List<String> gender = [
    'Please choose your gender',
    'Male',
    'Female',
  ];

  String selectedCity = 'Damascus';

  final _controllerName = TextEditingController();

  String selectedGender = //Text(
      'Please choose your gender';
  //  style: TextStyle(color: Colors.grey[300], fontSize: 16),
  //);

  @override
  void initState() {
    // BlocProvider.of<AuthCubit>(context).getUserProfileData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('main builder');
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding.top;
    final topPadding = (padding + 28);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          print('staaaaaaaaaaate is $state');
          const snackBar = SnackBar(
            content: Text('some thing went wrong'),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        buildWhen: (previous, current) =>
            current is UserDataScreenLoadingState ||
            current is UserDataScreenDoneState ||
            current is UserDataScreenErrorState,
        builder: (context, state) {
          print('bloc builder');
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 8, right: 8, bottom: 8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset('assets/images/splash1.png'),
                        height: (size.height - topPadding) * 15 / 70 < 107
                            ? 107
                            : (size.height - topPadding) * 15 / 70,
                      ),
                      SizedBox(
                          height: (size.height - topPadding) * 4 / 70 < 28
                              ? 28
                              : (size.height - topPadding) * 4 / 70),
                      Container(
                        height: (size.height - topPadding) * 8 / 70 < 57
                            ? 57
                            : (size.height - topPadding) * 8 / 70,
                        child: TextField(
                          controller: _controllerName,

                          //autofocus: false,
                          //cursorColor: Color(0XFFE06D00),
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            //labelStyle: TextStyle(color: Color(0xFFC6C8C1))
                            //  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: (size.height - topPadding) * 1 / 70 < 7
                              ? 7
                              : (size.height - topPadding) * 1 / 70),
                      Container(
                        height: (size.height - topPadding) * 8 / 70 < 57
                            ? 57
                            : (size.height - topPadding) * 8 / 70,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                selectedGender,
                                style: selectedGender ==
                                        'Please choose your gender'
                                    ? TextStyle(
                                        color: Colors.grey[300], fontSize: 16)
                                    : null,
                              ),
                              //  color: Colors.green,
                              // width: 90,
                              height: 45,
                              // height: size.height / 13.8 < 50 ? 50 : size.height / 13.8,
                            ),
                            Container(
                              color: Colors.white.withOpacity(0),
                              width: size.width,
                              // height: size.height / 12.8 < 50 ? 50 : size.height / 12.8,
                              height: 45,
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(
                                  onSelected: (String value) => setState(() {
                                        selectedGender = value;
                                      }),
                                  // tooltip: '',
                                  color: Colors.white,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 18, left: 310),
                                    width: size.width,
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.arrow_drop_down,
                                      //  color: Colors.black,
                                    ),
                                  ),
                                  itemBuilder: (ctx) => gender
                                      .map((gender) => PopupMenuItem(
                                            enabled: gender ==
                                                    'Please choose your gender'
                                                ? false
                                                : true,
                                            value: gender,
                                            child: Container(
                                              child: Text(
                                                gender,
                                                style: gender ==
                                                        'Please choose your gender'
                                                    ? TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 16)
                                                    : null,
                                              ),
                                              width: size.width * 0.8,
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ))
                                      .toList()),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: (size.height - topPadding) * 1 / 70 < 7
                              ? 7
                              : (size.height - topPadding) * 1 / 70),
                      Container(
                        height: (size.height - topPadding) * 8 / 70 < 57
                            ? 57
                            : (size.height - topPadding) * 8 / 70,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(selectedCity),
                              height: 45,
                              // height: size.height / 12.8 < 50 ? 50 : size.height / 12.8,
                            ),
                            Container(
                              color: Colors.white.withOpacity(0),
                              width: size.width,
                              height: 45,
                              //height: size.height / 12.8 < 50 ? 50 : size.height / 12.8,
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(
                                  onSelected: (String value) => setState(() {
                                        selectedCity = value;
                                      }),
                                  color: Colors.white,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 18, left: 310),
                                    width: size.width,
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                      Icons.arrow_drop_down,
                                      // color: Colors.black,
                                    ),
                                  ),
                                  itemBuilder: (ctx) => city
                                      .map((city) => PopupMenuItem(
                                            value: city,
                                            child: Container(
                                              child: Text(city),
                                              width: size.width * 0.8,
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ))
                                      .toList()),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: (size.height - topPadding) * 1 / 70 < 7
                              ? 7
                              : (size.height - topPadding) * 1 / 70),
                      Container(
                        height: (size.height - topPadding) * 5 / 70 < 36
                            ? 36
                            : (size.height - topPadding) * 5 / 70,
                        child: Container(
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
                                  Color(0XFFE64B2D).withOpacity(0.9),
                                  Color(0XFFF87600).withOpacity(0.9),
                                ],
                              )),
                          height: size.height / 16 < 40 ? 40 : size.height / 16,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
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
                              await BlocProvider.of<AuthCubit>(context)
                                  .addUserProfileData(_controllerName.text,
                                      selectedGender, selectedCity);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              height:
                                  size.height / 16 < 40 ? 40 : size.height / 16,
                              alignment: Alignment.center,
                              width: size.width * 0.75,
                              child: const Text(
                                'Next',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  //    backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: (size.height - topPadding) * 1 / 70 < 7
                              ? 7
                              : (size.height - topPadding) * 1 / 70),
                      Container(
                        child: Image.asset('assets/images/personalData.jpg'),
                        height: (size.height - topPadding) * 18 / 70 < 128
                            ? 128
                            : (size.height - topPadding) * 18 / 70,
                      ),
                    ],
                  ),
                ),
              ),
              if (state is UserDataScreenLoadingState)
                ModalBarrier(
                  color: Colors.black.withOpacity(0.3),
                  dismissible: false,
                  barrierSemanticsDismissible: false,
                ),
              if (state is UserDataScreenLoadingState)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
