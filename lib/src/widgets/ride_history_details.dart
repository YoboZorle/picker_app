import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/widgets/ride_status.dart';
import 'package:web_socket_channel/io.dart';

class IndividualRideCard extends StatefulWidget {
  Ride ride;

  IndividualRideCard(this.ride);

  @override
  _IndividualRideCardState createState() => _IndividualRideCardState();
}

class _IndividualRideCardState extends State<IndividualRideCard> {
  var _channel;
  final _storage = new FlutterSecureStorage();

  @override
  void initState() {
    _getRideUpdates();
    super.initState();
  }

  _getRideUpdates() async {
    final String jwtToken = await _storage.read(key: 'accessToken');
    _channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/delivery/ride-details/${widget.ride.id}/?token=$jwtToken");
    _channel.stream.listen((response) {
      var decodedResponse = json.decode(response)['ride'];
      setState(() {
        widget.ride = Ride.fromMap(decodedResponse);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/RideDetails',
          arguments: RideArguments(widget.ride)),
      child: Column(
        children: [
          SizedBox(height: 10),
          Card(
            elevation: 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: ListTile(
                title: Text(
                  widget.ride.deliveryLocation.address,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: "Ubuntu",
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      height: 1.6),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getFullTime(widget.ride.createdAt),
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Ubuntu",
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          height: 1.6),
                    ),
                    RideStatusText(widget.ride.status)
                  ],
                ),
                contentPadding: EdgeInsets.all(0),
                dense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
