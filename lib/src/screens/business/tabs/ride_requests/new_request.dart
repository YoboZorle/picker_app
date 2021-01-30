import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

class NewRequest extends StatelessWidget {
  final String title;

  NewRequest({Key key, this.title}) : super(key: key);

  final europeanCountries = [
    'Albania',
    'Andorra',
    'Armenia',
    'Austria',
    'Azerbaijan',
    'Belarus',
    'Belgium',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: europeanCountries.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Transform.rotate(
                                angle: 180 * pi / 80,
                                child: Icon(Icons.navigation_outlined,
                                    size: 16, color: Colors.grey)),
                          ),
                          TextSpan(
                              text: " 6.7km",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.access_time_rounded,
                                size: 15, color: Colors.grey),
                          ),
                          TextSpan(
                              text: " 14mins",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: " N600.00",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                ListTile(
                  leading: Text('From:',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Ubuntu')),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  title: Text('10 Sani Abacha road, Port Harcourt, Nigeria',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Ubuntu',
                          fontSize: 15)),
                  // subtitle:
                  //     Text('100 Sani Abacha road, Port Harcourt, Nigeria'),
                  contentPadding: EdgeInsets.all(0),
                ),
                ListTile(
                  leading: Text('To:',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Ubuntu')),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  title: Text('106 Victoria Street, Port Harcourt, Town, Nigeria',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Ubuntu')),
                  contentPadding: EdgeInsets.all(0),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: .7,
                    margin: EdgeInsets.only(top: 8, bottom: 12),
                    color: Colors.grey[200]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mon 14/12/2020, 2:11 PM ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Ubuntu')),
                    SizedBox(
                      height: 35,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                            side: BorderSide(color: AppColor.primaryText)),
                        onPressed: () {},
                        color: AppColor.primaryText,
                        textColor: Colors.white,
                        child: Text("Assign driver",
                            style:
                                TextStyle(fontSize: 13, fontFamily: 'Ubuntu')),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12)
              ],
            ),
          );
        },
      ),
    );
  }
}
