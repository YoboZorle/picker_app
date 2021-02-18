import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class RideInformationWidget extends StatefulWidget {
  final Ride rideDetails;

  RideInformationWidget(this.rideDetails);

  @override
  _RideInformationWidgetState createState() => _RideInformationWidgetState();
}

class _RideInformationWidgetState extends State<RideInformationWidget> {
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');

  @override
  Widget build(BuildContext context) {
    if (widget.rideDetails.status == 'CANCELED') {
      return cancelRideWidge();
    }
    if (widget.rideDetails.status == 'DELIVERED') {
      return deliveredRideWidget();
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
                    widget.rideDetails.rider.company != null
                        ? TextSpan(
                            text: widget.rideDetails.rider.company.name,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                                height: 1.5),
                          )
                        : TextSpan(),
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
                    Text('From where:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                            color: Colors.black45,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child:
                              Icon(Icons.circle, size: 12, color: Colors.green),
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
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 4),
                              Text(
                                  '+${widget.rideDetails.user.callingCode + widget.rideDetails.user.phone}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('To where:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                            color: Colors.black45,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(Icons.circle,
                              size: 12, color: Colors.orangeAccent),
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.rideDetails.deliveryLocation.address,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 4),
                              Text(widget.rideDetails.receiverName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 4),
                              Text(
                                  '+${widget.rideDetails.user.callingCode + widget.rideDetails.receiverPhone}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.5,
                        margin: EdgeInsets.only(bottom: 18),
                        color: Colors.grey[300]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text('15 mins',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Distance',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text(widget.rideDetails.distance + ' km',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text(
                                currencyFormatter
                                    .format(widget.rideDetails.price),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getFullTime(widget.rideDetails.createdAt),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                color: Colors.black45,
                                fontWeight: FontWeight.w400)),
                        Text('CANCELLED',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Ubuntu',
                                color: Colors.red,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ])),
        ],
      );

  Widget deliveredRideWidget() => Column(
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
                    Text('From where:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                            color: Colors.black45,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child:
                              Icon(Icons.circle, size: 12, color: Colors.green),
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
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 4),
                              Text(
                                  '+${widget.rideDetails.user.callingCode + widget.rideDetails.user.phone}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('To where:',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Ubuntu',
                            color: Colors.black45,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(Icons.circle,
                              size: 12, color: Colors.orangeAccent),
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.rideDetails.deliveryLocation.address,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 4),
                              Text(widget.rideDetails.receiverName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 4),
                              Text(
                                  '+${widget.rideDetails.user.callingCode + widget.rideDetails.receiverPhone}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.5,
                        margin: EdgeInsets.only(bottom: 18),
                        color: Colors.grey[300]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text('15 mins',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Distance',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text(widget.rideDetails.distance + ' km',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 4),
                            Text(
                                currencyFormatter
                                    .format(widget.rideDetails.price),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getFullTime(widget.rideDetails.createdAt),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Ubuntu',
                                color: Colors.black45,
                                fontWeight: FontWeight.w400)),
                        Text('DELIVERED',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Ubuntu',
                                color: Colors.green,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ])),
          widget.rideDetails.review != null
              ? Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Ride ratings:',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Ubuntu',
                                color: Colors.black45,
                                fontWeight: FontWeight.w400)),
                        SizedBox(height: 8),
                        ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                  child: Container(
                                height: 45.0,
                                width: 45.0,
                                child: !widget.rideDetails.rider.details.noProfileImage
                                    ? CustomImage(
                                        imageUrl:
                                            '${widget.rideDetails.rider.details.profileImageUrl}',
                                      )
                                    : Image.asset(
                                        'assets/images/placeholder.jpg',
                                        width: double.infinity,
                                        height: double.infinity),
                              )),
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.rideDetails.rider.details.fullname,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: "Ubuntu",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                              SmoothStarRating(
                                allowHalfRating: true,
                                onRatingChanged: (value) {},
                                starCount: 5,
                                rating: widget.rideDetails.review.star.toDouble(),
                                size: 11.0,
                                color: Colors.amber,
                                borderColor: Colors.grey[400],
                                spacing: 0,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  widget.rideDetails.review.review,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Ubuntu",
                                      height: 1.35,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)),
                              Text(getChatTime( widget.rideDetails.review.createdAt),
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: "Ubuntu",
                                      color: Colors.grey,
                                      height: 1.3,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ]))
              : Container(),
        ],
      );
}
