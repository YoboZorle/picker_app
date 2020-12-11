import 'package:equatable/equatable.dart';

class RideDetailsEvent extends Equatable {
  const RideDetailsEvent();

  @override
  List<Object> get props => [];
}

class RideDetailsLoaded extends RideDetailsEvent {
  final Map<String, dynamic> rideDetails;

  const RideDetailsLoaded({this.rideDetails});

  @override
  List<Object> get props => [rideDetails];

  @override
  String toString() {
    return 'RideDetailsLoaded { rideDetails: $rideDetails }';
  }
}
