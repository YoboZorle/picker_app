import 'package:flutter/material.dart';
import 'package:pickrr_app/src/screens/business/tabs/ride_requests/request_models.dart';

class BusinessDrivers extends StatelessWidget {
  final String title;

  BusinessDrivers({Key key, this.title}) : super(key: key);

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
            padding: EdgeInsets.only(top: 10),
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
              subtitle: Text(
                'Driver is available',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontFamily: 'Ubuntu'),
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
              trailing: Icon(Icons.circle, size: 16, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}
