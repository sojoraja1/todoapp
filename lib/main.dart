import 'package:flutter/material.dart';
import 'package:todoapp/ui/home.dart';

void main(){


  runApp(
    
    MaterialApp(
      title: "TodoApp",
  debugShowCheckedModeBanner: false,
      home: HomeView(),


    )
  );
}