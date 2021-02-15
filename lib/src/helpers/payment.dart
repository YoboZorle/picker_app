import 'package:flutter/material.dart';

Dialog errorDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)), //this right here
    child: Container(
      height: 350.0,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.cancel,
              color: Colors.red,
              size: 90,
            ),
            SizedBox(height: 15),
            Text(
              'Failed to process payment',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              "Error in processing payment, please try again",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    ),
  );
}

Dialog successDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)), //this right here
    child: Container(
      height: 350.0,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_box,
              color: Color(0xFF41aa5e),
              size: 90,
            ),
            SizedBox(height: 15),
            Text(
              'Payment has successfully',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'been made',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              "Your payment has been successfully",
              style: TextStyle(fontSize: 13),
            ),
            Text("processed.", style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    ),
  );
}