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
          height: 8,
          width: 60,
          margin: EdgeInsets.only(top: 15, bottom: 18),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
        ),
        Container(
          height: 200,
          child: new FlareActor('assets/flare/rider.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: 'RidertoStore'),
        ),
        new Text(
          "A driver will be assigned\nto you shortly...",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
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
            margin: EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 0),
            child: Text('Cancel ride',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    color: Colors.black87,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () async => cancelRide(context, rideId),
        ),
      ],
    );
  }
}
