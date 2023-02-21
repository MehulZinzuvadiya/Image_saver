import 'package:flutter/material.dart';
import 'package:practice/practice.dart';

void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>HomePage(),
      },
    ),
  );
}