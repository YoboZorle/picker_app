import 'package:flutter/material.dart';

class BusinessDrivers extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text("Drivers"),
          actions: [
            FlatButton(
                onPressed: () => {},
                color: Colors.orange,
                child: Text("Add driver")
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () => {},
                color: Colors.orange,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("Add")
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
}