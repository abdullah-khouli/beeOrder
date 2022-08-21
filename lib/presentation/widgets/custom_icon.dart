//import 'package:beeorder/widgets/custom_circle.dart';
import 'package:flutter/material.dart';

import 'custom_circle.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Color(0XFFEF6C00),
                  height: 2,
                ),
              ),
              Expanded(
                  child: Container(
                height: 2,
                color: Color(0XFFEF6C00),
              )),
              Expanded(
                  child: Container(
                height: 2,
                color: const Color(0XFFEF6C00),
              )),
              Expanded(child: buildCircle(context)),
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              ))
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              )),
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              )),
              Expanded(child: buildCircle(context)),
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              )),
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              ))
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              )),
              Expanded(child: buildCircle(context)),
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              )),
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              )),
              Expanded(
                  child: Container(
                color: Color(0XFFEF6C00),
                height: 2,
              ))
            ],
          ),
          // SizedBox(height: 1),
        ],
      ),
    );
  }
}
