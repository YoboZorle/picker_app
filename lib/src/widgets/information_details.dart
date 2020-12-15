import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:url_launcher/url_launcher.dart';

class RideInformationWidget extends StatefulWidget {
  final Ride rideDetails;

  RideInformationWidget(this.rideDetails);

  @override
  _RideInformationWidgetState createState() => _RideInformationWidgetState();
}

class _RideInformationWidgetState extends State<RideInformationWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.rideDetails.status == 'CANCELED') {
      return cancelRideWidge();
    }
    if (widget.rideDetails.status == 'DELIVERED') {
      return Container(child: Text("Package Delivered"));
    }
    return Column(
      children: [
        Container(
          height: 8,
          width: 60,
          margin: EdgeInsets.only(top: 15, bottom: 18),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
        ),
        new Text(
          "Rider arrives in 2 mins",
          maxLines: 1,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Ubuntu",
              color: Colors.black,
              fontWeight: FontWeight.w700,
              height: 1.35),
        ),
        SizedBox(height: 15),
        ListTile(
          trailing: Column(
            children: [
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: ClipOval(
                        child: Container(
                            height: 70.0,
                            width: 70.0,
                            child: !widget
                                    .rideDetails.rider.details.noProfileImage
                                ? CustomImage(
                                    imageUrl:
                                        '${widget.rideDetails.rider.details.profileImageUrl}',
                                  )
                                : Image.asset('assets/images/placeholder.jpg',
                                    fit: BoxFit.cover)))),
              ),
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.rideDetails.rider.companyName,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Ubuntu",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                          height: 1.5),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.circle, size: 8, color: Colors.grey),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' Plate Number: ${widget.rideDetails.rider.plateNumber}',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Ubuntu",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
              Text(
                widget.rideDetails.rideId,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: "Ubuntu",
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    height: 1.6),
              ),
            ],
          ),
          subtitle: RichText(
            text: TextSpan(
                text: 'Your driver is ',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Ubuntu",
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    height: 1.6),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.rideDetails.rider.details.fullname,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Ubuntu",
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        height: 1.6),
                  )
                ]),
          ),
          contentPadding: EdgeInsets.only(left: 20),
          dense: true,
        ),
        GestureDetector(
          child: Container(
            height: 45,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 10, left: 25, right: 25, top: 25),
            decoration: BoxDecoration(
              color: AppColor.primaryText,
              boxShadow: [Shadows.secondaryShadow],
              borderRadius: Radii.kRoundpxRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone_rounded, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('Call Driver',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Ubuntu',
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          onTap: () => launch(
              "tel://+${widget.rideDetails.rider.details.callingCode}${widget.rideDetails.rider.details.phone}"),
        ),
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
          onTap: () async => cancelRide(context, widget.rideDetails.id,
              nextRoute: '/RideHistory'),
        ),
      ],
    );
  }

  Widget cancelRideWidge() => Column(
        children: [
          Container(
              color: Colors.white,
              child: Row(children: [
                GestureDetector(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_outlined,
                              size: 21, color: Colors.black),
                        ),
                        Text('Ride Details',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Ubuntu',
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ])),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(getFullTime(widget.rideDetails.createdAt),
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            color: Colors.black45,
                            fontWeight: FontWeight.w400)),
                    Text('From where:',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            color: Colors.black45,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(Icons.circle, size: 12, color: Colors.green),
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.rideDetails.pickupLocation.address,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 4),
                              Text(widget.rideDetails.user.fullname,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 4),
                              Text('+${widget.rideDetails.user.callingCode + widget.rideDetails.user.phone}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(Icons.circle, size: 12, color: Colors.orangeAccent),
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Text(widget.rideDetails.deliveryLocation.address,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),

                    SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('CANCELLED',
                              style: TextStyle(
                                  fontSize: 14.5,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400)),
                      ],
                    ),

                  ])),
        ],
      );
}
