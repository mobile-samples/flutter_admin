import 'package:flutter/material.dart';

spaceHeight(double size) {
  return SizedBox(height: size);
}

spaceHeightWithChild(double size, Widget? child) {
  return SizedBox(height: size, child: child);
}

spaceWidth(double size) {
  return SizedBox(width: size);
}
