import 'package:flutter/material.dart';

class RideStatusText extends StatelessWidget {
  final String status;

  RideStatusText(this.status);

  @override
  Widget build(BuildContext context) {
    if (status == 'CANCELED') {
      return Text(
        'CANCELLED',
        style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Ubuntu",
            color: Colors.red,
            fontWeight: FontWeight.w400,
            height: 1.6),
      );
    }
    if (status == 'DELIVERED') {
      return Text(
        'RIDE FINISHED',
        style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Ubuntu",
            color: Colors.green,
            fontWeight: FontWeight.w400,
            height: 1.6),
      );
    }

    if (status == 'PENDING') {
      return Text(
        'AWAITING RIDER',
        style: TextStyle(
            fontSize: 16.0,
            fontFamily: "Ubuntu",
            color: Colors.blue,
            fontWeight: FontWeight.w400,
            height: 1.6),
      );
    }
    return Text(
      'SCHEDULED',
      style: TextStyle(
          fontSize: 16.0,
          fontFamily: "Ubuntu",
          color: Colors.orange,
          fontWeight: FontWeight.w400,
          height: 1.6),
    );
  }
}
