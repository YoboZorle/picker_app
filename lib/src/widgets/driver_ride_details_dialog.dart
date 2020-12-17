import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/repositories/user.dart';
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
    ride = widget.ride;
    _getRideUpdates();
  }

  _getRideUpdates() async {
    Driver riderDetails = await _driverRepository.getDriverDetailsFromStorage();
    if (ride.status == 'CANCELED' ||
        ride.status == 'DELIVERED' &&
            ride.rider.details.id != riderDetails.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    if (ride.status == 'INPROGRESS' &&
        ride.rider.details.id != riderDetails.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    final String jwtToken = await _storage.read(key: 'accessToken');
    _channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/delivery/ride-details/${widget.ride.id}/?token=$jwtToken");
    _channel.stream.listen((response) async {
      var decodedResponse = json.decode(response)['ride'];
      Ride rideDetails = Ride.fromMap(decodedResponse);
      await _rideDetailsCheck(rideDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ride.status == 'INPROGRESS' || ride.status == 'PENDING') {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   ClipOval(
                          child: Container(
                              height: 65.0,
                              width: 65.0,
                              child: !ride.user.noProfileImage
                                  ? CustomImage(
                                imageUrl: '${ride.user.profileImageUrl}',
                              )
                                  : Image.asset('assets/images/placeholder.jpg',
                                  fit: BoxFit.cover))),
                    SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Name: ',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
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
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Pickup: ',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Ubuntu",
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
                        TextSpan(
                          text: ride.pickupLocation.address,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              height: 1.6),
                        ),
                      ]),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        margin:
                        EdgeInsets.only(top: 5, right: 50),
                        decoration: BoxDecoration(
                          borderRadius: Radii.kRoundpxRadius,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.phone_rounded, color: Colors.green, size: 20),
                            SizedBox(width: 8),
                            Text('Call +${ride.user.callingCode}${ride.user.phone}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      onTap: () =>
                          launch("tel://+${ride.user.callingCode}${ride.user.phone}"),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.only(left: 20),
                dense: true,
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
                                  bottom: 5, left: 25, right: 25, top: 15),
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
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.red,
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

      var rawDetails = await _rideRepository.processAcceptRide(ride.id);
      Ride rideDetails = Ride.fromMap(rawDetails);
      await _rideDetailsCheck(rideDetails);
      Navigator.pop(context);
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      if (err.message != null) {
        AlertBar.dialog(context, err.message, Colors.red,
            icon: Icon(Icons.error), duration: 5);
      }
      AlertBar.dialog(context, 'Request could not be completed', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  _rideDetailsCheck(Ride rideDetails) async {
    if (rideDetails.status == 'CANCELED' ||
        rideDetails.status == 'DELIVERED' &&
            rideDetails.rider.details.id != ride.rider.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    if (rideDetails.status == 'INPROGRESS' &&
        rideDetails.rider.details.id != ride.rider.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    setState(() {
      ride = rideDetails;
    });

    if (ride.status == 'DELIVERED' &&
        rideDetails.rider.details.id == ride.rider.id) {
      await UserRepository().getUserDetails(rideDetails.rider.details.id);
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

      Ride rideDetails =
          Ride.fromMap(await _rideRepository.processPackagePicked(ride.id));
      Navigator.pop(context);
      await _rideDetailsCheck(rideDetails);
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      if (err.message != null) {
        AlertBar.dialog(context, err.message, Colors.red,
            icon: Icon(Icons.error), duration: 5);
      }
      AlertBar.dialog(context, 'Request could not be completed', Colors.red,
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

      Ride rideDetails =
          Ride.fromMap(await _rideRepository.processPackageDelivered(ride.id));
      Navigator.pop(context);
      await _rideDetailsCheck(rideDetails);
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      if (err.message != null) {
        AlertBar.dialog(context, err.message, Colors.red,
            icon: Icon(Icons.error), duration: 5);
      }
      AlertBar.dialog(context, 'Request could not be completed', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }
}
