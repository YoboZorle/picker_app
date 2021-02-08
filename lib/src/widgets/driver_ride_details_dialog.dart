import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
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
  final VoidCallback onProcess;

  RiderOrderInteractiveLayout(this.ride, {this.onProcess});

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
  Driver _driver;

  @override
  void initState() {
    super.initState();
    ride = widget.ride;
    _getRideUpdates();
  }

  _getRideDetails() async {
    var rawDetails = await _rideRepository.getRideDetails(ride.id);
    Ride rideDetails = Ride.fromMap(rawDetails);
    if (rideDetails != null) {
      // setState(() => {
      ride = rideDetails;
      // });
    }
  }

  _getRideUpdates() async {
    _getRideDetails();
    _driver = await _driverRepository.getDriverDetailsFromStorage();
    if (ride.status == 'CANCELED' ||
        ride.status == 'DELIVERED' && ride.rider.details.id != _driver.id) {
      widget.onProcess();
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    if (ride.status == 'INPROGRESS' && ride.rider.details.id != _driver.id) {
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
    if (ride.status == 'CANCELED') {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => Navigator.pushNamed(context, '/DriversHomePage'));
    }
    if (ride.status == 'INPROGRESS' || ride.status == 'PENDING') {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.2,
          child: Column(
            children: [
              SizedBox(
                height: 25,
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
              ListTile(
                  leading: ClipOval(
                      child: Container(
                          height: 55.0,
                          width: 55.0,
                          child: !ride.user.noProfileImage
                              ? CustomImage(
                                  imageUrl: '${ride.user.profileImageUrl}',
                                )
                              : Image.asset('assets/images/placeholder.jpg',
                                  fit: BoxFit.cover))),
                  title: Text(ride.user.fullname,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500)),
                  subtitle: Text('+${ride.user.callingCode}${ride.user.phone}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Ubuntu',
                          height: 1.7,
                          fontWeight: FontWeight.w400)),
                  trailing: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.phone, color: Colors.black),
                      onPressed: () {
                        launch(
                            "tel://+${ride.user.callingCode}${ride.user.phone}");
                      },
                    ),
                  )),
              Container(
                  height: 0.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300],
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          margin: EdgeInsets.only(right: 8),
                          child: Text("From: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                        Flexible(
                          child: Text(ride.pickupLocation.address,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          margin: EdgeInsets.only(right: 8),
                          child: Text("To: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                        Flexible(
                          child: Text(ride.deliveryLocation.address,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 25),
                  child: Builder(builder: (BuildContext context) {
                    return ride.status == 'INPROGRESS'
                        ? Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: ride.isPickedUp
                                      ? ButtonTheme(
                                          height: 45,
                                          child: RaisedButton(
                                            child: Text('Package Delivered',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            onPressed: () =>
                                                _processPackageDelivered(),
                                            color: AppColor.primaryText,
                                            elevation: 12,
                                          ),
                                        )
                                      : ButtonTheme(
                                          height: 45,
                                          child: RaisedButton(
                                            color: AppColor.primaryText,
                                            child: Text('Picked Up Package',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Ubuntu',
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            onPressed: () =>
                                                _processPackagePicked(),
                                            elevation: 12,
                                          ),
                                        )),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ButtonTheme(
                                  height: 45,
                                  child: RaisedButton(
                                    child: Text('Cancel',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Ubuntu',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                    color: Colors.grey[300],
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    elevation: 0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 2,
                                child: ButtonTheme(
                                  height: 45,
                                  child: RaisedButton(
                                    child: Text('Accept ride',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Ubuntu',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                    color: AppColor.primaryText,
                                    elevation: 12,
                                    onPressed: () => _processAcceptRide(),
                                  ),
                                ),
                              ),
                            ],
                          );
                  })),
            ],
          ));
    }
    return Container(
        height: MediaQuery.of(context).size.height / 2.6,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 25),
            Icon(Icons.check_circle, color: Colors.green, size: 70),
            SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              margin: EdgeInsets.only(bottom: 10),
              child: Text("Success!",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("You have successfully completed your ride.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontSize: 15)),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(children: <Widget>[
                Expanded(
                  child: ButtonTheme(
                    height: 45,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Done",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Ubuntu",
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      color: AppColor.primaryText,
                      elevation: 12,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ));
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
      widget.onProcess();
      Navigator.pop(context);
    } catch (err) {
      Navigator.pop(context);
      if (err is ServiceError) {
        AlertBar.dialog(context, err.message, Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }
      AlertBar.dialog(context, 'Request could not be completed', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  _rideDetailsCheck(Ride rideDetails) async {
    if (rideDetails.status == 'CANCELED' ||
        rideDetails.status == 'DELIVERED' &&
            rideDetails.rider.details.id != _driver.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }
    if (rideDetails.status == 'INPROGRESS' &&
        rideDetails.rider.details.id != _driver.id) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Ride already taken!', Colors.orange,
          icon: Icon(Icons.info), duration: 5);
    }

    setState(() {
      ride = rideDetails;
    });

    if (ride.status == 'DELIVERED' &&
        rideDetails.rider.details.id == _driver.id) {
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
      if (err is ServiceError) {
        AlertBar.dialog(context, err.message, Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
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
      if (err is ServiceError) {
        AlertBar.dialog(context, err.message, Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }
      AlertBar.dialog(context, 'Request could not be completed', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }
}
