import 'package:equatable/equatable.dart';

abstract class RatedRidesEvent extends Equatable {
  const RatedRidesEvent();

  @override
  List<Object> get props => [];
}

class RatedRidesReset extends RatedRidesEvent {}

class RatedRidesFetched extends RatedRidesEvent {
  final int riderId;

  const RatedRidesFetched(this.riderId);

  @override
  List<Object> get props => [];
}
