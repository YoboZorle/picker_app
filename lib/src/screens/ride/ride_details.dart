import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/widgets/awaiting_ride.dart';
import 'package:pickrr_app/src/widgets/information_details.dart';
import 'package:web_socket_channel/io.dart';
import 'package:pickrr_app/src/models/ride.dart';

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
    _getRideUpdates();
  }

  _getRideUpdates() async {
    final String jwtToken = await _storage.read(key: 'accessToken');
    _channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/delivery/ride-details/${widget.arguments.ride.id}/?token=$jwtToken");
    _channel.stream.listen((response) {
      var decodedResponse = json.decode(response)['ride'];
      Ride ride = Ride.fromMap(decodedResponse);
      if(ride.status == 'INPROGRESS' && ride.isPickedUp){
        WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.pushReplacementNamed(context, '/RideHistory'));
      }
      setState(() {
        widget.arguments.ride = ride;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        top: true,
        child: ListView(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                child: widget.arguments.ride.status == 'PENDING'
                    ? AwaitingRideWidget(
                        rideStatus: widget.arguments.ride.status,
                        rideId: widget.arguments.ride.id,
                      )
                    : RideInformationWidget(widget.arguments.ride)),
          ],
        ),
      ),
    );
  }
}
