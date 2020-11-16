import 'package:flutter/material.dart';
import 'package:pickrr_app/src/values/values.dart';

class TrackRides extends StatefulWidget {
  @override
  _TrackRidesState createState() => _TrackRidesState();
}

class _TrackRidesState extends State<TrackRides> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Log',
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.primaryText,
          title: Text(
            'Track Deliveries',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: "Ubuntu",
                fontSize: 18),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.white),
          ),
        ),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {

  final transact_id = [
    '3542749',
    '2548176',
    '2653673',
    '2988893',
    '0680793',
    '2564822',
    'su23884',
    '2871672',
    '9872928'
  ];
  final address = [
    '24 Victoria street, Port harcourt',
    '40 Dline street, Port harcourt',
    '4B Abacha road, Off GRA, Port harcourt',
    '216 Lagos Street, Town ',
    '200 Nembe street, Port harcourt',
    '39 Island Layout, Porrt harcout',
    '281 Freetown Close, Port harcourt ',
    '12B Avenue Ndoki, Port harcourt',
    '4 Delta Junction, Port harcourt'
  ];

  final dates = [
    '8/11',
    '5/11',
    '3/11',
    '1/11',
    '30/10',
    '23/10',
    '21/10',
    '19/10',
    '15/10'
  ];

  final time = [
    '10:45 AM',
    '3:32 PM',
    '2:40 PM',
    '4:02 PM',
    '1:23 PM',
    '11:29 AM',
    '11:11 AM',
    '3:23 PM',
    '12:05 AM'
  ];

  final status = [
    'In progress',
    'Scheduled',
    'Shipped',
    'Shipped',
    'Cancelled',
    'Shipped',
    'Cancel',
    'Shipped',
    'Shipped'
  ];

  final type = [
    'Packed meals from Chicken republic',
    'Package textiles',
    'Bevearages',
    'Shoes',
    'Food',
    'Books',
    'Books',
    'Package',
    'Packed meals'
  ];

  bool isShipped = true;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transact_id.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Card(
            elevation: 0,
            child: ListTile(
              leading: Text(dates[index],
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: "Ubuntu",
                      color: AppColors.primaryText,
                      fontSize: 16)),
              title: Text('Transaction ID: ' + transact_id[index],
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Ubuntu",
                      color: Colors.black,
                      fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address[index],
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Ubuntu",
                          color: AppColors.primaryText,
                          fontSize: 15)),
                  SizedBox(height: 3),
                  Text(type[index],
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                          fontSize: 15)),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(time[index],
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Ubuntu",
                              color: Colors.grey,
                              fontSize: 15)),
                      Text(status[index],
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Ubuntu",
                              color: isShipped ? Colors.grey : Colors.cyan,
                              fontSize: 15)),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          ),
        );
      },
    );
  }
}


