import 'package:flutter/material.dart';

class BusinessDriverActivitySecond extends StatefulWidget {
  BusinessDriverActivitySecond({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BusinessDriverActivitySecondState createState() =>
      _BusinessDriverActivitySecondState();
}

class _BusinessDriverActivitySecondState
    extends State<BusinessDriverActivitySecond>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Try here again '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: const Text('showModalBottomSheet'),
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 282,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.yellowAccent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18.0),
                                      topRight: const Radius.circular(18.0),
                                      bottomLeft: const Radius.circular(18.0),
                                      bottomRight: const Radius.circular(18.0),
                                    ),
                                  ),
                                  child: DefaultTabController(
                                    length: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TabBar(
                                              tabs: [
                                                Tab(
                                                    icon: Icon(
                                                  Icons.directions_car,
                                                  color: Colors.black,
                                                )),
                                                Tab(
                                                    icon: Icon(
                                                  Icons.star_rate_rounded,
                                                  color: Colors.black,
                                                )),
                                                Tab(
                                                    icon: Icon(
                                                  Icons.image,
                                                  color: Colors.black,
                                                )),
                                                Tab(
                                                    icon: Icon(
                                                  Icons.directions_transit,
                                                  color: Colors.black,
                                                )),
                                              ],
                                            ),
                                            Expanded(
                                              child: TabBarView(
                                                children: <Widget>[
                                                  Text(
                                                    'the first tab view',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  Text(
                                                    'second',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  Text(
                                                    'third',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  Text(
                                                    'fourth',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                    ),
                                  ));
                            }),
                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
