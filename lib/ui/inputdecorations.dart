import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String labeltextt,
    required String hinText,
    IconData? prefixIcon,
}
   ) {
    return  InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText:hinText,
        label: Text(labeltextt),
        labelStyle: const TextStyle(color: Colors.grey),
        prefix: (prefixIcon != null)
        ? Icon(prefixIcon,color: Colors.purple,)
        :null
        );
  }
}
