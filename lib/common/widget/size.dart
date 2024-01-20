import 'package:flutter/material.dart';

class AppSizedWidget {
  static spaceHeight(double size) {
    return SizedBox(height: size);
  } 

  static spaceHeightWithChild(double size, Widget? child) {
    return SizedBox(
      height: size,
      child: child
    );
  } 

  static spaceWidth(double size) {
    return SizedBox(width: size);
  } 
}