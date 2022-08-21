//d
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.controller,
  }) : super(key: key);
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: FocusNode(canRequestFocus: false),
      textAlign: TextAlign.left,
      maxLines: null,
      controller: controller,
      cursorColor: Colors.grey[700],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: Icon(Icons.search),
        hintText: 'search by restaurant or item',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
      ),
    );
  }
}
