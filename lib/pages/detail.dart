import 'package:flutter/material.dart';
import 'package:Hogwarts/component/detail/tag.dart';
import 'package:Hogwarts/component/detail/comment.dart';

class Detail extends StatelessWidget {
  final spot;
  const Detail({Key key, this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(spot['name']),
      ),
      body: ListView(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
            child: Image.asset(
              spot['image'],
              width: MediaQuery.of(context).size.width,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  spot['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.grey[200]),
                    Text(spot['rate']),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    ShopTag(
                      icon: Icons.supervised_user_circle,
                      content: spot['count'],
                      color: Colors.pink[200],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ShopTag(
                      icon: Icons.bubble_chart,
                      content: spot['heat'],
                      color: Colors.cyan[200],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  spot['profile'],
                  style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 1,
                      wordSpacing: 3,
                      height: 1.2),
                ),
                SizedBox(
                  height: 10,
                ),
//                Comment(),
                SizedBox(height: 20)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
