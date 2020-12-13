import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/widgets/awaiting_ride.dart';
import 'package:pickrr_app/src/widgets/information_details.dart';
import 'package:web_socket_channel/io.dart';

class RideDetails extends StatefulWidget {
  final RideArguments arguments;

  RideDetails(this.arguments);

  @override
  _RideDetailsState createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  final _storage = new FlutterSecureStorage();
  var _channel;

  @override
  void initState() {
    super.initState();
  }

  _getRideUpdates() async {
    final String jwtToken = await _storage.read(key: 'accessToken');
    _channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/delivery/ride-details/${widget.arguments.ride.id}/?token=$jwtToken");
    // _channel.stream.listen((response) {
    //   var decodedResponse = json.decode(response)['ride'];
    //   print('decodedResponse=========================================================');
    //   print('decodedResponse=======================');
    //   print('decodedResponse---------------------------------------------------------');
    //   print(decodedResponse);
    // });
  }

  @override
  Widget build(BuildContext context) {
    _getRideUpdates();
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  Container(),
                  SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 15, 16, 8),
                        child: Hero(
                          tag: "nav",
                          flightShuttleBuilder: flightShuttleBuilder,
                          child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 23,
                                      ),
                                    )),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              }),
                        )),
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    Shadows.primaryShadow,
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: widget.arguments.ride.status == 'PENDING'
                    ? AwaitingRideWidget(
                        rideStatus: widget.arguments.ride.status, rideId: widget.arguments.ride.id,)
                    : RideInformationWidget(widget.arguments.ride)),
          ],
        ),
      ),
    ));
  }
}
