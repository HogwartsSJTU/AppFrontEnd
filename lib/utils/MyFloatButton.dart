import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unicorndial/unicorndial.dart';

class MyFloatButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyFloatButtonState();
}

class _MyFloatButtonState extends State<MyFloatButton> {
  List<UnicornButton> _getProfileMenu() {
    List<UnicornButton> children = [];

    // Add Children here
    children.add(_profileOption(iconData: Icons.event_busy, onPressed:() {}, tag: "关闭"));
    children.add(_profileOption(iconData: Icons.exit_to_app, onPressed: (){}, tag: "打开"));
    children.add(_profileOption(iconData: Icons.delete_outline, onPressed: () {}, tag: "删除"));

    return children;
  }

  Widget _profileOption({IconData iconData, Function onPressed, String tag}) {
    return UnicornButton(
      currentButton: FloatingActionButton(
        backgroundColor: Colors.grey[500],
        mini: true,
        child: Icon(iconData),
        tooltip: tag,
        onPressed: onPressed,
        heroTag: tag,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      UnicornDialer(
        parentButtonBackground: Colors.grey[700],
        orientation: UnicornOrientation.HORIZONTAL,
        parentButton: Icon(Icons.build),
        childButtons: _getProfileMenu(),
      );
  }
}
