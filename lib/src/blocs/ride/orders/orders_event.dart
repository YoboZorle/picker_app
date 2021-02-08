import 'package:equatable/equatable.dart';
import 'package:pickrr_app/src/models/ride.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersReset extends OrdersEvent {}

class OrdersFetched extends OrdersEvent {
  final int isUser;
  const OrdersFetched({this.isUser = 1});

  @override
  List<Object> get props => [isUser];
}

class OrdersAdded extends OrdersEvent {
  final Ride ride;
  const OrdersAdded(this.ride);

  @override
  List<Object> get props => [ride];
}

class OrderRemoved extends OrdersEvent {
  final Ride ride;

  const OrderRemoved({this.ride});

  @override
  List<Object> get props => [ride];
}