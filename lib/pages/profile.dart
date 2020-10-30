import 'dart:io';

import 'package:flutter/material.dart';


class Profile extends StatefulWidget{
  Profile({this.userId});

  final int userId;

  @override
  State<StatefulWidget> createState() {
    return new _ProfileState();
  }
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Text("UserId: " + widget.userId.toString()),
        )
    );
  }

}


