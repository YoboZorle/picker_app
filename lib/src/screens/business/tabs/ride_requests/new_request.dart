import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/screens/business/tabs/ride_requests/assign_driver.dart';
import 'package:pickrr_app/src/screens/business/tabs/ride_requests/request_models.dart';

class NewRequest extends StatelessWidget {
  final String title;

  NewRequest({Key key, this.title}) : super(key: key);

  static List<RequestModels> allRequests() {
    var lstOfRequests = new List<RequestModels>();

    lstOfRequests.add(new RequestModels(
        fromAddress: "20 Egbema Street, Borikiri, Port harcourt, Nigeria",
        toAddress: "66-4 Parkhurst Rd, Chelmsford MA 1824 ",
        rideAmount: "N400.00",
        rideDistance: "6.3km",
        rideTime: "9mins",
        date: "Mon 14/12/2020, 2:11 PM "));
    lstOfRequests.add(new RequestModels(
        fromAddress: "137 Teaticket Hwy, East Falmouth MA 2536",
        toAddress: "1775 Washington St, Hanover MA 2339",
        rideAmount: "N650.00",
        rideDistance: "10km",
        rideTime: "14mins",
        date: "Mon 14/12/2020, 2:11 PM "));
    lstOfRequests.add(new RequestModels(
        fromAddress: "34 Plymouth Street, Halifax MA 2338",
        toAddress: "301 Massachusetts Ave, Lunenburg MA 1462",
        rideAmount: "N700.00",
        rideDistance: "8mins",
        rideTime: "18mins",
        date: "Mon 14/12/2020, 2:11 PM "));
    lstOfRequests.add(new RequestModels(
        fromAddress: "742 Main Street, North Oxford MA 1537",
        toAddress: "1180 Fall River Avenue, Seekonk MA 2771",
        rideAmount: "N800.00",
        rideDistance: "8km",
        rideTime: "23mins",
        date: "Mon 14/12/2020, 2:11 PM "));
    lstOfRequests.add(new RequestModels(
        fromAddress: "3005 Cranberry Hwy Rt 6 28, Wareham MA 2538",
        toAddress: "141 Washington Ave Extension, Albany NY 12205",
        rideAmount: "N1,200.00",
        rideDistance: "11km",
        rideTime: "15mins",
        date: "Mon 14/12/2020, 2:11 PM "));
    lstOfRequests.add(new RequestModels(
        fromAddress: "333 Main Street, Tewksbury MA 1876",
        toAddress: "62 Swansea Mall Dr, Swansea MA 2777",
        rideAmount: "N950.00",
        rideDistance: "4.8km",
        rideTime: "9mins",
        date: "Mon 14/12/2020, 2:11 PM "));
    return lstOfRequests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: allRequests().length,
        padding: EdgeInsets.all(0.0),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        allRequests()[index].rideDistance +
                            '/' +
                            allRequests()[index].rideTime,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Ubuntu')),
                    Text(allRequests()[index].date,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Ubuntu')),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      margin: EdgeInsets.only(right: 8),
                      child: Text("From: ",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400)),
                    ),
                    Flexible(
                      child: Text(allRequests()[index].fromAddress,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      margin: EdgeInsets.only(right: 8),
                      child: Text("To: ",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400)),
                    ),
                    Flexible(
                      child: Text(allRequests()[index].toAddress,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.7,
                    margin: EdgeInsets.only(top: 18),
                    color: Colors.grey[200]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(allRequests()[index].rideAmount,
                        style: TextStyle(
                            color: Color(0xFF16B9BB),
                            fontSize: 14,
                            fontFamily: 'Ubuntu')),
                    InkWell(
                      child: Container(
                        height: 35,
                        padding: EdgeInsets.only(left: 30),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Text("ASSIGN DRIVER",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF7057D2),
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w500)),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward_ios_outlined,
                                color: Color(0xFF7057D2), size: 16)
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return AssignDriver();
                              },
                              fullscreenDialog: true,
                            ));
                      },
                      splashColor: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
