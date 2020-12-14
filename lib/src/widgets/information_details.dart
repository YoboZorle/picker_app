import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:url_launcher/url_launcher.dart';

class RideInformationWidget extends StatelessWidget {
  final Ride rideDetails;

  RideInformationWidget(this.rideDetails);

  @override
  Widget build(BuildContext context) {
    if (rideDetails.status == 'CANCELED') {
      return Container();
    }
    if (rideDetails.status == 'DELIVERED') {
      return Container();
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
                            child: !rideDetails.rider.details.noProfileImage
                                ? CustomImage(
                                    imageUrl:
                                        '${rideDetails.rider.details.profileImageUrl}',
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
                      text: rideDetails.rider.companyName,
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
                      text: ' Plate Number: ${rideDetails.rider.plateNumber}',
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
                rideDetails.rideId,
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
                    text: rideDetails.rider.details.fullname,
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
              "tel://+${rideDetails.rider.details.callingCode}${rideDetails.rider.details.phone}"),
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
          onTap: () async => cancelRide(context, rideDetails.id, nextRoute: '/RideHistory'),
        ),
      ],
    );
  }
}
