import 'package:equatable/equatable.dart';
import 'package:pickrr_app/src/models/ride.dart';

abstract class BusinessOrdersEvent extends Equatable {
  const BusinessOrdersEvent();

  @override
  List<Object> get props => [];
}

class BusinessOrdersReset extends BusinessOrdersEvent {}

class BusinessOrdersFetched extends BusinessOrdersEvent {
  const BusinessOrdersFetched();

  @override
  List<Object> get props => [];
}

class BusinessOrdersAdded extends BusinessOrdersEvent {
  final Ride ride;

  const BusinessOrdersAdded(this.ride);

  @override
  List<Object> get props => [ride];
}

class BusinessOrdersRemoved extends BusinessOrdersEvent {
  final Ride ride;

  const BusinessOrdersRemoved(this.ride);

  @override
  List<Object> get props => [ride];
}
