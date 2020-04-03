import 'package:flutter/material.dart';
import 'package:todoapp/ui/screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(title: Text("TodoApp"),backgroundColor: Colors.black54,),
        body: NotoDoScreen(),

    );
  }
}