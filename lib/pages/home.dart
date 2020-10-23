import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  HomePage({Key key}) : super(key: key);

  State<StatefulWidget> createState(){
    return RecommendedPage();
  }
}

class RecommendedPage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Freelancer',
            key: Key('title'),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          brightness: Brightness.light,
        ),
        body: Center(child: Text("HOME"),)
    );
  }
}
