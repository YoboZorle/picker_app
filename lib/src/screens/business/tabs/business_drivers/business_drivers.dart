import 'package:flutter/material.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_drivers/business_driver_activity.dart';

class BusinessDrivers extends StatelessWidget {
  final String title;

  BusinessDrivers({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Yobo Zorle',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Ubuntu'),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver is available',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        height: 1.3,
                        fontFamily: 'Ubuntu'),
                  ),
                ],
              ),
              leading: Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://blog.bolt.eu/wp-content/uploads/2020/06/1200x628_Oaksure-Financial-Services-insurance-covers-Bolt-passengers-and-drivers-on-all-rides.jpg")))),
              trailing: Icon(Icons.arrow_forward_ios_outlined,
                  size: 16, color: Colors.grey[300]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return BusinessDriverActivity();
                      },
                      fullscreenDialog: true,
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}
