import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

class AwaitingRideWidget extends StatelessWidget {
  final String rideStatus;
  final int rideId;

  AwaitingRideWidget({this.rideStatus, this.rideId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: new FlareActor('assets/flare/rider.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: 'RidertoStore'),
        ),
        new Text(
          "A rider will be assigned\nto you within 5 minutes...",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 17.0,
              fontFamily: "Ubuntu",
              color: Colors.black,
              fontWeight: FontWeight.w700,
              height: 1.35),
        ),
        SizedBox(height: 20),
        GestureDetector(
          child: Container(
            height: 45,
            alignment: Alignment.center,
            color: Colors.red,
            margin: EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 0),
            child: Text('Cancel ride',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () async => cancelRide(context, rideId),
        ),

        SizedBox(height: 10),
        GestureDetector(
          child: Container(
            height: 45,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 0),
            child: Text('Minimize',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    color: Colors.green,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
