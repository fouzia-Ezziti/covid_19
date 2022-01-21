import 'package:flutter/material.dart';
import 'data_source.dart';
import 'home_page.dart';
//import 'package:untitled/data_source.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Circular',
      primaryColor: primaryBlack,


    ),
    home: HomePage(),
  ));

}
