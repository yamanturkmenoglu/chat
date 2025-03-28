import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CusttomTextFild extends StatelessWidget {
  CusttomTextFild({super.key, required this.hinttitle, this.onChanged});
  final String hinttitle;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'form is impety';
          }
          return null;
        },
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintText: hinttitle,
            hintStyle: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
