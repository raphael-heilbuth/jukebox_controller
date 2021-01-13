import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function onClick;

  FloatingButton({this.color = Colors.blueAccent, this.icon = Icons.attach_money, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    onPressed: () => onClick(),
    child: Icon(icon),
    backgroundColor: color,
    );
  }
}
