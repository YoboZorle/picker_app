import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/io.dart';

class RideInteraction extends StatefulWidget {
  final Ride ride;

  RideInteraction(this.ride);

  @override
  _RideInteractionState createState() => _RideInteractionState(this.ride);
}

class _RideInteractionState extends State<RideInteraction> {
  Ride ride;
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  final _storage = new FlutterSecureStorage();
  final RideRepository _rideRepository = RideRepository();
  var _channel;
  bool _removeRide = false;

  _RideInteractionState(this.ride);

  @override
  void initState() {
    super.initState();
    _getRideUpdates();
  }

  _getRideUpdates() async {
    if (ride.status == 'CANCELED' || ride.status == 'DELIVERED') {
      _removeRide = true;
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

  _rideDetailsCheck(Ride rideDetails) async {
    if (rideDetails.status == 'CANCELED' || rideDetails.status == 'DELIVERED') {
      setState(() {
        _removeRide = true;
      });
    }
    setState(() {
      ride = rideDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_removeRide
        ? Card(
            elevation: 0,
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: ClipOval(
                        child: Container(
                      height: 45.0,
                      width: 45.0,
                      child: !ride.user.noProfileImage
                          ? CustomImage(
                              imageUrl: '${ride.user.profileImageUrl}',
                            )
                          : Image.asset('assets/images/placeholder.jpg',
                              width: double.infinity, height: double.infinity),
                    )),
                    title: Text(
                      ride.user.fullname,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Ubuntu",
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          height: 1.6),
                    ),
                    subtitle: Text(
                      ride.distance + ' km' + '/' + ride.duration + ' ride',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: "Ubuntu",
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          height: 1.5),
                    ),
                    trailing: Text(currencyFormatter.format(ride.price),
                        style: TextStyle(
                            color: Color(0xFF16B9BB),
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                  ),
                  SizedBox(height: 5),
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
                                fontSize: 13.5,
                                color: Colors.black,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                                fontSize: 13.5,
                                color: Colors.black,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0.7,
                      margin: EdgeInsets.only(top: 18, bottom: 10),
                      color: Colors.grey[200]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 5, right: 50),
                          decoration: BoxDecoration(
                            borderRadius: Radii.kRoundpxRadius,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.phone_in_talk_rounded,
                                    color: Colors.black, size: 18),
                                SizedBox(width: 8),
                                Text('Call ' + ride.user.phone,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ),
                        onTap: () => launch("tel://+" +
                            ride.user.callingCode +
                            ride.user.phone),
                      ),
                      Expanded(
                        child: Builder(builder: (BuildContext context) {
                          if (!ride.isPickedUp && ride.status == 'INPROGRESS') {
                            return actionButton(
                              onPress: () => _processPackagePicked(),
                              text: "PICKED UP",
                            );
                          }
                          if (ride.isPickedUp && ride.status == 'INPROGRESS') {
                            return actionButton(
                              onPress: () => _processPackageDelivered(),
                              text: "DELIVERED",
                            );
                          }
                          return Container();
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget actionButton({@required VoidCallback onPress, @required String text}) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      color: AppColor.primaryText,
      textColor: AppColor.primaryText,
      padding: EdgeInsets.only(left: 25, right: 25),
      onPressed: onPress,
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500)),
    );
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
          Ride.fromMap(await _rideRepository.processPackagePickedForRider(ride.id));
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
          Ride.fromMap(await _rideRepository.processPackageDeliveredForRider(ride.id));
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
