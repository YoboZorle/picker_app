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
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ride.distance + ' km' + '/' + ride.duration + ' ride',
                        style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: "Ubuntu",
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            height: 1.6),
                      ),
                      Text(currencyFormatter.format(ride.price),
                          style: TextStyle(
                              color: Color(0xFF16B9BB),
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        width: 52,
                        child: Text("Sender: ",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400)),
                      ),
                      Flexible(
                        child: SelectableText(ride.pickupLocation.address,
                            style: TextStyle(
                                fontSize: 13.5,
                                color: Colors.black,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
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
                    title: SelectableText(
                      ride.user.fullname,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Ubuntu",
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          height: 1.6),
                    ),
                    subtitle: SelectableText(
                      "+234${ride.user.phone}",
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: "Ubuntu",
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          height: 1.5),
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.4),
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
                    ),
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0.6,
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      color: Colors.grey[300]),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        margin: EdgeInsets.only(right: 8),
                        child: Text("Receiver: ",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400)),
                      ),
                      Flexible(
                        child: SelectableText(ride.deliveryLocation.address,
                            style: TextStyle(
                                fontSize: 13.5,
                                color: Colors.black,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: Text("Receiver's name: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.w400)),
                              ),
                              SelectableText(ride.receiverName,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: Text("Receiver phone: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.w400)),
                              ),
                              SelectableText(ride.receiverPhone,
                                  style: TextStyle(
                                      fontSize: 13.5,
                                      color: Colors.black,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: Text("Payment Method: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.w400)),
                              ),
                              SelectableText(ride.methodOfPayment,
                                  style: TextStyle(
                                      fontSize: 13.5,
                                      color: Colors.black,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.4),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.phone, color: Colors.black),
                          onPressed: () {
                            launch(
                                "tel://+${ride.user.callingCode}${ride.receiverPhone}");
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0.6,
                      margin: EdgeInsets.only(top: 18, bottom: 10),
                      color: Colors.grey[300]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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

      Ride rideDetails = Ride.fromMap(
          await _rideRepository.processPackagePickedForRider(ride.id));
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

      Ride rideDetails = Ride.fromMap(
          await _rideRepository.processPackageDeliveredForRider(ride.id));
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
