import 'package:pickrr_app/src/models/ride.dart';

class RideDetailsArguments {
  final double price;
  final Map<String, dynamic> pickupCoordinate;
  final Map<String, dynamic> destinationCoordinate;
  final String receiversFullName;
  final String receiversPhone;
  final String distance;
  final String duration;

  RideDetailsArguments(
      this.price,
      this.pickupCoordinate,
      this.destinationCoordinate,
      this.receiversFullName,
      this.receiversPhone, this.distance, this.duration);
}


class RideArguments {
  final Ride ride;

  RideArguments(this.ride);
}