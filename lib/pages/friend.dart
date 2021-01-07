import 'package:Hogwarts/utils/FilterStaticDataType.dart';
import 'package:Hogwarts/utils/multi_select_item.dart';
import 'package:flutter/material.dart';
import 'package:Hogwarts/component/chat/favorite_contacts.dart';
import 'package:Hogwarts/component/chat/recent_chats.dart';
import 'package:Hogwarts/component/dialog/multi_select_dialog_field.dart';

//data
class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}

List<Animal> _animals = [
  Animal(id: 1, name: "童童"),
  Animal(id: 2, name: "小尚"),
  Animal(id: 3, name: "郭郭"),
  Animal(id: 4, name: "斌斌"),
  Animal(id: 5, name: "Tiger"),
  Animal(id: 6, name: "Penguin"),
  Animal(id: 7, name: "Spider"),
  Animal(id: 8, name: "Snake"),
  Animal(id: 9, name: "Bear"),
  Animal(id: 10, name: "Beaver"),
  Animal(id: 11, name: "Cat"),
  Animal(id: 12, name: "Fish"),
  Animal(id: 13, name: "Rabbit"),
  Animal(id: 14, name: "Mouse"),
  Animal(id: 15, name: "Dog"),
  Animal(id: 16, name: "Zebra"),
  Animal(id: 17, name: "Cow"),
  Animal(id: 18, name: "Frog"),
  Animal(id: 19, name: "Blue Jay"),
  Animal(id: 20, name: "Moose"),
  Animal(id: 21, name: "Gecko"),
  Animal(id: 22, name: "Kangaroo"),
  Animal(id: 23, name: "Shark"),
  Animal(id: 24, name: "Crocodile"),
  Animal(id: 25, name: "Owl"),
  Animal(id: 26, name: "Dragonfly"),
  Animal(id: 27, name: "Dolphin"),
];
final _items = _animals
    .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
    .toList();
List<Animal> _selectedAnimals = [];
List<Animal> _selectedAnimals2 = [];
List<Animal> _selectedAnimals3 = [];
List<Animal> _selectedAnimals4 = [];
List<Animal> _selectedAnimals5 = [];
final _multiSelectKey = GlobalKey<FormFieldState>();



class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  int lanIndex = GlobalSetting.globalSetting.lanIndex;
  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          lanIndex == 0 ? '聊天':'Chat',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
//          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  MultiSelectDialogField(
                    items: _items,
                    title: Text(lanIndex == 0 ?"好友列表":'Contacts'),
                    selectedColor: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    buttonIcon: Icon(
                      Icons.people,
                      color: Colors.blue,
                    ),
                    buttonText: Text(
                      lanIndex == 0 ?"邀请好友组队":'Invite your Friends',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      _selectedAnimals = results;
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    iconSize: 30.0,
                    color: Colors.blue,
                    onPressed: () { _alert();},
                  ),
                  FavoriteContacts(),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _alert(){
    String tmp = (lanIndex == 0 ?"确定和以下好友组队吗?\n\n":"Are you sure to team up with the following friends?\n\n");
    for (var i = 0; i < _selectedAnimals.length; i++) {
      tmp += _selectedAnimals[i].name + "\n";
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(lanIndex == 0 ?'组队确认':'Team Confirmation'),
          content: Text(tmp),
          actions: <Widget>[
            new FlatButton(
              child: new Text(lanIndex == 0 ?"取消":'Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(lanIndex == 0 ?"确定":'OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));

  }
}
