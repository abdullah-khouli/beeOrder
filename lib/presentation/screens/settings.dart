import 'package:beeorder_bloc/logic/cubit/auth_cubit.dart';
import 'package:beeorder_bloc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  String selectedLanguage = 'En';
  bool sellang = true;
  bool not = true;
  bool SMS = true;
  bool WhatsApp = true;

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: size.height / 16 < 40 ? 40 : size.height / 16,
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: size.width * 0.3 > 135 ? 135 : size.width * 0.3,
          leading: Container(
            padding: EdgeInsets.only(left: size.width * 0.04),
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all(const EdgeInsets.only(left: 0)),
                overlayColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: size.height / 40 < 16 ? 16 : size.height / 40,
                color: Colors.black,
              ),
              label: Text(
                'Settings',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: size.height / 46 < 14 ? 14 : size.height / 46),
              ),
            ),
          )),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 2,
            child: const Divider(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: size.height -
                MediaQuery.of(context).padding.top -
                2 -
                (size.height / 16 < 40 ? 40 : size.height / 16),
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(bottom: 75),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: const Text('Choose a Language'),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Row(
                              children: [
                                Checkbox(
                                    side: const BorderSide(width: 0.5),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    value: !sellang,
                                    onChanged: (bool? x) {
                                      print(x);
                                      print('object');
                                      if (x != null && x != false)
                                        setState(() {
                                          sellang = !x;
                                        });
                                    }),
                                const Text('Arabic')
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Row(
                              children: [
                                Checkbox(
                                    side: BorderSide(width: 0.5),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    value: sellang,
                                    onChanged: (bool? x) {
                                      print(x);
                                      if (x != null && x != false)
                                        setState(() {
                                          sellang = x;
                                        });
                                    }),
                                Text('English')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 25,
                      color: Color(0xFFECEEF1),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Text('Get Offers Though'),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Row(
                              children: [
                                Checkbox(
                                    side: BorderSide(width: 0.5),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    value: not,
                                    onChanged: (bool? x) {
                                      print(x);
                                      if (x != null)
                                        setState(() {
                                          not = x;
                                        });
                                    }),
                                Text('Notifications'),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Row(
                              children: [
                                Checkbox(
                                    side: const BorderSide(width: 0.5),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    value: SMS,
                                    onChanged: (bool? x) {
                                      print(x);
                                      print('object');
                                      if (x != null) {
                                        setState(() {
                                          SMS = x;
                                        });
                                      }
                                    }),
                                Text('SMS'),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Row(
                              children: [
                                Checkbox(
                                    side: const BorderSide(width: 0.5),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    value: WhatsApp,
                                    onChanged: (bool? x) {
                                      print(x);
                                      print('object');
                                      if (x != null)
                                        setState(() {
                                          WhatsApp = x;
                                        });
                                    }),
                                const Text('WhatsApp'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 25,
                      color: const Color(0xFFECEEF1),
                    ),
                    Column(
                      children: [
                        InkWell(
                          splashColor: const Color(0xFFECEEF1),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Text('Contact us'),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color(0xFFECEEF1),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Text('Join Us'),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color(0xFFECEEF1),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Text('FAQ'),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color(0xFFECEEF1),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Text('About'),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color(0xFFECEEF1),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Text('Privacy Policy'),
                          ),
                        ),
                        InkWell(
                          splashColor: const Color(0xFFECEEF1),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: const Text('Terms of Services'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width,
                      height: 25,
                      color: const Color(0xFFECEEF1),
                    ),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is SnackBarAuthLoadingFailedState) {
                          final snackBar = SnackBar(
                            content: Text(state.error),
                          );
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (state is InternetConnectionFailed) {
                          const snackBar = SnackBar(
                            content: Text('No internet connection'),
                          );
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: InkWell(
                        splashColor: const Color(0xFFECEEF1),
                        onTap: () async {
                          await BlocProvider.of<AuthCubit>(context).logout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const MyApp()),
                              (route) => false);
                          print('done');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: const Text('Log Out'),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
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
                            const Color(0XFFE64B2D).withOpacity(0.9),
                            const Color(0XFFF87600).withOpacity(0.9),
                          ],
                        )),
                    height: size.height / 16 < 40 ? 40 : size.height / 16,
                    margin: const EdgeInsets.only(bottom: 25),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        height: size.height / 16 < 40 ? 40 : size.height / 16,
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        child: const Text(
                          'save',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            //    backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  group1SelectedVaue(String? value) {
    setState(() {
      selectedLanguage = value!;
    });
    ;
  }
}
