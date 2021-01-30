import 'package:flutter/material.dart';


class NewRequest extends StatelessWidget {
  final String title;

  NewRequest({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(child: Text('New request!')),

    );
  }
}