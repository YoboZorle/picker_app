import 'package:equatable/equatable.dart';

abstract class RideDetailsState extends Equatable {
  const RideDetailsState();

  @override
  List<Object> get props => [];
}

class EmptyDetails extends RideDetailsState {}

class RideDetails extends RideDetailsState {
  final Map<String, dynamic> rideDetails;

  const RideDetails(this.rideDetails);

  @override
  List<Object> get props => [rideDetails];

  @override
  String toString() => 'RideDetails { rideDetails: $rideDetails }';
}
