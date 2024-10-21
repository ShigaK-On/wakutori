import 'package:flutter/material.dart';

List<double> containerSize(bool header, Size screenSize) {
  double heightDivisor = 2.5;
  if (!header) {
    heightDivisor = 2;
  }
  List<double> size = [screenSize.width / 8, (screenSize.width / 8) / heightDivisor];
  if (screenSize.width > screenSize.height) {
    if (screenSize.width < 1000) {
      size[0] = screenSize.width / 6.5;
      size[1] = (screenSize.width / 6.5) / heightDivisor;
    }
    return size;
  } else {
    double widthDivisor = 2.75;
    if(screenSize.height > 800) {
      widthDivisor = 2.5;
    }
    size[0] = screenSize.width / 2.75;
    size[1] = (screenSize.width / widthDivisor) / heightDivisor;
    return size;
  }
}