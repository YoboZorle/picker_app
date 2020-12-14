import 'package:equatable/equatable.dart';
import 'package:pickrr_app/src/models/ride.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersReset extends OrdersEvent {}

class OrdersFetched extends OrdersEvent {
  const OrdersFetched();

  @override
  List<Object> get props => [];
}

class OrdersAdded extends OrdersEvent {
  final Ride ride;
  const OrdersAdded(this.ride);

  @override
  List<Object> get props => [ride];
}