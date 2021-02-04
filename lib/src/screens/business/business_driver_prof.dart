import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import 'driver_reviews.dart';

class BusinessDriverProf extends StatefulWidget {
  @override
  _BusinessDriverProfState createState() => _BusinessDriverProfState();
}

class _BusinessDriverProfState extends State<BusinessDriverProf> {
  bool _switchValues = true;
  bool _blockDriver = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your Driver',
          style: TextStyle(
              fontFamily: "Ubuntu",
              fontSize: 17.0,
              color: Colors.black,
              fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
              size: 20,
            )),
        actions: [
          IconButton(icon: Icon(Icons.logout, color: Colors.red, size: 22), onPressed: (){
            ConfirmAlertBoxDark(
                context: context,
                title:
                'Are you sure you want to delete driver?',
                titleTextColor: Colors.white,
                icon: Icons.eighteen_mp,
                infoMessage: '',
                onPressedYes: () {});
          })
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: [
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 85.0,
                                height: 85.0,
                                margin: EdgeInsets.only(right: 20,left: 20),
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                            "https://bloximages.chicago2.vip.townnews.com/stlamerican.com/content/tncms/assets/v3/editorial/1/cb/1cb65068-c76d-11e8-8686-7f40e5fbe1d0/5bb5605309dba.image.jpg?resize=400%2C422")))),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text('QLink - BY87R',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          height: 1.3,
                                          fontFamily: "Ubuntu",
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                    "Amadi Chibuzor",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        height: 1.3,
                                        fontFamily: "Ubuntu",
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text('Ticket ID - 445677723',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.grey,
                                          height: 1.4,
                                          fontWeight: FontWeight.w400)),
                                  Text('08038752226',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          height: 1.3,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                  Text('yobozorle@gmail.com',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black,
                                          height: 1.3,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 0.7,
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300]),
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 15),
                            child: ListTileSwitch(
                              contentPadding: EdgeInsets.all(0),
                              value: _switchValues,
                              onChanged: (value) {
                                setState(() {
                                  _switchValues = value;
                                });
                              },
                              toggleSelectedOnValueChange: true,
                              subtitle: Text(
                                  'Toggle button to activate or deactivate your driver.',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: "Ubuntu",
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5)),
                              switchActiveColor: Colors.green,
                              switchType: SwitchType.material,
                              title: Text(
                                  _switchValues == false
                                      ? 'Driver Unavailable'
                                      : 'Driver Available',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w400,
                                      height: 1.6)),
                            ),
                          ),
                        ),
                        Container(
                            height: 0.7,
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300]),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicatorPadding: EdgeInsets.only(left: 50, right: 50, top: 50),
                indicatorWeight: 3,
                unselectedLabelStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Ubuntu'),
                labelStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Ubuntu'),
                physics: BouncingScrollPhysics(),
                tabs: [
                  Tab(text: 'Rides'),
                  Tab(text: 'Reviews'),
                  Tab(text: 'Transactions'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Center(child: Text('First here')),
                    DriverReviews(),
                    Center(child: Text('Third here'))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
