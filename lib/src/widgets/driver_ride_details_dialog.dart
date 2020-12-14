import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:web_socket_channel/io.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';
import 'package:pickrr_app/src/widgets/image.dart';

class RiderOrderInteractiveLayout extends StatefulWidget {
  final Ride ride;

  RiderOrderInteractiveLayout(this.ride);

  @override
  _RiderOrderInteractiveLayoutState createState() =>
      _RiderOrderInteractiveLayoutState();
}

class _RiderOrderInteractiveLayoutState
    extends State<RiderOrderInteractiveLayout> {
  final _storage = new FlutterSecureStorage();
  final DriverRepository _driverRepository = DriverRepository();
  final RideRepository _rideRepository = RideRepository();
  var _channel;
  Ride ride;

  @override
  void initState() {
    super.initState();
    setState(() {
      ride = widget.ride;
    });
    _getRideUpdates();
  }

  _getRideUpdates() async {
    if (ride.status == 'CANCELED' ||
        ride.status == 'DELIVERED' && ride.rider.id != ride.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    if (ride.status == 'INPROGRESS' && ride.rider.id != ride.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    final String jwtToken = await _storage.read(key: 'accessToken');
    Driver riderDetails = await _driverRepository.getDriverDetailsFromStorage();
    _channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/delivery/ride-details/${widget.ride.id}/?token=$jwtToken");
    _channel.stream.listen((response) {
      var decodedResponse = json.decode(response)['ride'];
      Ride rideDetails = Ride.fromMap(decodedResponse);
      if (rideDetails.status == 'CANCELED' ||
          rideDetails.status == 'DELIVERED' &&
              rideDetails.rider.details.id != riderDetails.id) {
        Navigator.pop(context);
        AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
            icon: Icon(Icons.info), duration: 5);
      }
      if (rideDetails.status == 'INPROGRESS' &&
          rideDetails.rider.details.id != riderDetails.id) {
        Navigator.pop(context);
        AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
            icon: Icon(Icons.info), duration: 5);
      }
      setState(() {
        ride = rideDetails;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ride.status == 'INPROGRESS' || ride.status == 'PENDING') {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              Shadows.primaryShadow,
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 8,
                width: 60,
                margin: EdgeInsets.only(top: 15, bottom: 18),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16)),
              ),
              Text(
                ride.status == 'INPROGRESS'
                    ? ride.isPickedUp
                        ? "Meet and Pickup"
                        : "Deliver Package"
                    : "New Request!",
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Ubuntu",
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.35),
              ),
              SizedBox(height: 10),
              ListTile(
                trailing: Column(
                  children: [
                    Expanded(
                      child: ClipOval(
                          child: Container(
                              height: 70.0,
                              width: 70.0,
                              child: !ride.user.noProfileImage
                                  ? CustomImage(
                                      imageUrl: '${ride.user.profileImageUrl}',
                                    )
                                  : Image.asset('assets/images/placeholder.jpg',
                                      fit: BoxFit.cover))),
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
                            text: 'Name: ',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                height: 1.5),
                          ),
                          TextSpan(
                            text: ride.user.fullname,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                subtitle: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Pickup: ',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Ubuntu",
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          height: 1.5),
                    ),
                    TextSpan(
                      text: ride.pickupLocation.address,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 1.6),
                    ),
                  ]),
                ),
                contentPadding: EdgeInsets.only(left: 20),
                dense: true,
              ),
              GestureDetector(
                child: Container(
                  height: 45,
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(bottom: 5, left: 25, right: 25, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: Radii.kRoundpxRadius,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_rounded, color: Colors.black, size: 20),
                      SizedBox(width: 8),
                      Text('Call +${ride.user.callingCode}${ride.user.phone}',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                onTap: () =>
                    launch("tel://+${ride.user.callingCode}${ride.user.phone}"),
              ),
              Builder(builder: (BuildContext context) {
                return ride.status == 'INPROGRESS'
                    ? Column(
                        children: [
                          ride.isPickedUp
                              ? GestureDetector(
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        bottom: 10,
                                        left: 25,
                                        right: 25,
                                        top: 18),
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryText,
                                      boxShadow: [Shadows.secondaryShadow],
                                      borderRadius: Radii.kRoundpxRadius,
                                    ),
                                    child: Text('Delivered',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  onTap: () => _processPackageDelivered(),
                                )
                              : GestureDetector(
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        bottom: 10,
                                        left: 25,
                                        right: 25,
                                        top: 18),
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryText,
                                      boxShadow: [Shadows.secondaryShadow],
                                      borderRadius: Radii.kRoundpxRadius,
                                    ),
                                    child: Text('Picked Up Package',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  onTap: () => _processPackagePicked(),
                                )
                        ],
                      )
                    : Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 25, right: 25, top: 18),
                              decoration: BoxDecoration(
                                color: AppColor.primaryText,
                                boxShadow: [Shadows.secondaryShadow],
                                borderRadius: Radii.kRoundpxRadius,
                              ),
                              child: Text('Accept',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                            onTap: () => _processAcceptRide(),
                          ),
                          GestureDetector(
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 25, right: 25, top: 0),
                              child: Text('Decline ride',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500)),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
              })
            ],
          ));
    }
    return Container(child: Text("Package delivered!"));
  }

  _processAcceptRide() async {
    AlertBar.dialog(context, 'Processing request...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }

      await _rideRepository
          .processAcceptRide(ride.id);
      Navigator.pop(context);
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  _processPackagePicked() async {
    AlertBar.dialog(context, 'Processing request...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }

      await _rideRepository
          .processPackagePicked(ride.id);
      Navigator.pop(context);
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  _processPackageDelivered() async {
    AlertBar.dialog(context, 'Processing request...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }

      await _rideRepository
          .processPackageDelivered(ride.id);
      Navigator.pop(context);
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }
}
