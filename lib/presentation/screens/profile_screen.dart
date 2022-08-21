import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  // String selectedCity = '';
  final _controllerName = TextEditingController();
  final _controllerNumber = TextEditingController(text: '957319628');
  final _controllerAddress = TextEditingController(text: '');
  // DateTime? selectedDate;
  //String selectedGender = 'Please choose your gender';

  final _date = DateTime(2000);

  @override
  void initState() {
    // BlocProvider.of<AuthCubit>(context).getUserProfileData();
    /* _controllerName.text = BlocProvider.of<AuthCubit>(context).authRep.username;
    selectedCity = BlocProvider.of<AuthCubit>(context).authRep.city;
    selectedGender = BlocProvider.of<AuthCubit>(context).authRep.gender;*/
    print(
        'iniiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiit');
    // print(selectedCity);
    // print(_controllerName.text);
    //print(selectedGender);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print(
        'didChangedeppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        /* backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios),
        leadingWidth: 20,
        titleSpacing: 0,
        title: Text('Profile'),*/
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: const Color(0xFFECEEF1),
          splashColor: const Color(0xFFECEEF1),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<AuthCubit>(context).getUserProfileData();
            print('');
          },
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              print('staaaaaaaaaaate is $state');
              if (state is GettingUserDataFailed) {
                const snackBar = SnackBar(
                  content: Text('some thing went wrong'),
                );
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            buildWhen: (previous, current) =>
                current is GettingUserData ||
                current is GettingUserDataDone ||
                current is GettingUserDataFailed,
            builder: (context, state) {
              /* _controllerName.text =
                  BlocProvider.of<AuthCubit>(context).authRep.username;*/
              _controllerAddress.text =
                  BlocProvider.of<AuthCubit>(context).authRep.email;
              print('blocBuild');
              return Stack(
                children: [
                  ListView(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    //   padding: const EdgeInsets.symmetric(horizontal: 0),
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        height: size.height / 14.222 < 45
                            ? 45
                            : size.height / 14.222,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: TextButton.icon(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(left: 20),
                                ),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            label: const Text(
                              'Profile',
                              style: TextStyle(color: Colors.black),
                            ),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Colors.grey[600],
                          thickness: 0.6,
                        ),
                      ),
                      Container(
                        height: size.height / 10.666 < 50
                            ? 50
                            : size.height / 10.666,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Builder(builder: (context) {
                          print('rebuild textfeild');
                          print(BlocProvider.of<AuthCubit>(context)
                              .authRep
                              .username);
                          _controllerName.text =
                              BlocProvider.of<AuthCubit>(context)
                                  .authRep
                                  .username;
                          return TextFormField(
                            /* initialValue: BlocProvider.of<AuthCubit>(context)
                                .authRep
                                .username,*/
                            controller: _controllerName,
                            onChanged: (value) {
                              BlocProvider.of<AuthCubit>(context)
                                  .authRep
                                  .username = value;
                            },
                            //autofocus: false,
                            //cursorColor: Color(0XFFE06D00),
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              //labelStyle: TextStyle(color: Color(0xFFC6C8C1))
                              //  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: size.height / 64),
                      Container(
                        height: size.height / 10.666 < 50
                            ? 50
                            : size.height / 10.666,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: _controllerNumber,
                          readOnly: true,
                          // cursorColor: Color(0XFFEF6C00),
                          decoration: const InputDecoration(
                            // fillColor: Color(0XFFEF6C00),
                            labelText: 'Phone Number',
                            //  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height / 64),
                      Container(
                        height: size.height / 10.666 < 50
                            ? 50
                            : size.height / 10.666,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          readOnly: true,
                          controller: _controllerAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                        ),
                      ),
                      SizedBox(height: size.height / 25.6),
                      Container(
                        height:
                            size.height / 12.8 < 50 ? 50 : size.height / 12.8,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: BlocBuilder<AuthCubit, AuthState>(
                                buildWhen: (previous, current) =>
                                    current is LocalGenderChanged,
                                // current is GettingUserDataDone,
                                builder: (context, state) {
                                  print('rebuild gender');
                                  return Text(
                                    BlocProvider.of<AuthCubit>(context)
                                        .authRep
                                        .gender,
                                    style: BlocProvider.of<AuthCubit>(context)
                                                .authRep
                                                .gender ==
                                            'Please choose your gender'
                                        ? TextStyle(
                                            color: Colors.grey[300],
                                            fontSize: 16)
                                        : null,
                                  );
                                },
                              ),
                              //  color: Colors.green,
                              // width: 90,
                              height: size.height / 12.8 < 50
                                  ? 50
                                  : size.height / 12.8,
                            ),
                            Container(
                              color: Colors.white.withOpacity(0),
                              width: size.width,
                              height: size.height / 12.8 < 50
                                  ? 50
                                  : size.height / 12.8,
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(
                                  onSelected: (String value) {
                                    //setState(() {
                                    BlocProvider.of<AuthCubit>(context)
                                        .localEditGender(value);
                                    //selectedGender = value;
                                    //
                                  },
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
                      Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: _getDateFromUser,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 15,
                              right: 20,
                              top: size.height / 32,
                              bottom: size.height / 128),
                          height: size.height / 8.533 < 60
                              ? 60
                              : size.height / 8.533,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Date of birth'),
                              //  if (selectedDate != null)
                              BlocBuilder<AuthCubit, AuthState>(
                                buildWhen: (previous, current) =>
                                    current is LocalDateChanged,
                                builder: (context, state) {
                                  final date =
                                      BlocProvider.of<AuthCubit>(context)
                                          .authRep
                                          .date;
                                  return Text(
                                      //   DateFormat('y-MM-d').format(selectedDate!)),
                                      date != null
                                          ? DateFormat('y-MM-d').format(
                                              BlocProvider.of<AuthCubit>(
                                                      context)
                                                  .authRep
                                                  .date!)
                                          : '');
                                },
                              ),

                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height / 42.666666666,
                        color: const Color(0xFFECEEF1),
                      ),
                      SizedBox(height: size.height / 32),
                      Container(
                        height:
                            size.height / 12.8 < 50 ? 50 : size.height / 12.8,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: BlocBuilder<AuthCubit, AuthState>(
                                buildWhen: (previous, current) =>
                                    current is LocalCityChanged,
                                builder: (context, state) {
                                  print('rebuild city');
                                  return Text(
                                      BlocProvider.of<AuthCubit>(context)
                                          .authRep
                                          .city);
                                },
                              ),
                              height: size.height / 12.8 < 50
                                  ? 50
                                  : size.height / 12.8,
                            ),
                            Container(
                              color: Colors.white.withOpacity(0),
                              width: size.width,
                              height: size.height / 12.8 < 50
                                  ? 50
                                  : size.height / 12.8,
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(
                                  onSelected: (String value) {
                                    // setState(() {

                                    BlocProvider.of<AuthCubit>(context)
                                        .localEditCity(value);
                                    // selectedCity = value;
                                    //  });
                                  },
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
                        height: size.height / 25.6,
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
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
                                .editUserProfileData();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            height:
                                size.height / 16 < 40 ? 40 : size.height / 16,
                            alignment: Alignment.center,
                            width: size.width * 0.75,
                            child: const Text(
                              'save',
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
                      if (size.height <
                          ((1 / 64 + 1 / 64 + 1 / 25.6 + 1 / 32) * size.height +
                              397 +
                              25))
                        const SizedBox(
                          height: 25,
                        )
                    ],
                  ),
                  if (state is GettingUserData)
                    ModalBarrier(
                      color: Colors.black.withOpacity(0.3),
                      dismissible: false,
                      barrierSemanticsDismissible: false,
                    ),
                  if (state is GettingUserData)
                    const Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1920),
      firstDate: DateTime(1920),
      lastDate: DateTime(DateTime.now().year),
    );
    if (_pickedDate != null) {
      //selectedDate = _pickedDate;
      BlocProvider.of<AuthCubit>(context).localEditDate(_pickedDate);
      /*print('selectedDate==$selectedDate');
      print(selectedDate!.year);
      print(selectedDate!.month);
      print(selectedDate!.day);
      print('hour${selectedDate!.hour}');
      print('min${selectedDate!.minute}');
      print('sec${selectedDate!.second}');*/
    } else {
      print('null');
    }
  }
}
