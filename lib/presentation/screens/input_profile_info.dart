import 'package:flutter/material.dart';

class InputProfileInfo extends StatelessWidget {
  const InputProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Container(height: size.height / 5),
        TextField(),
        TextField(),
        TextField(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 2), blurRadius: 2.0)
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
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                height: size.height / 16 < 40 ? 40 : size.height / 16,
                alignment: Alignment.center,
                width: size.width * 0.8,
                child: const Text(
                  'Next',
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
    ));
  }
}
