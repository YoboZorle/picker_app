import 'package:flutter/material.dart';


class NewRequest extends StatelessWidget {
  final String title;

  NewRequest({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('New request!')),

    );
  }
}