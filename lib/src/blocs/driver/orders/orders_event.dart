import 'package:equatable/equatable.dart';

abstract class RiderOrdersEvent extends Equatable {
  const RiderOrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersReset extends RiderOrdersEvent {}

class RiderOrdersFetched extends RiderOrdersEvent {
  const RiderOrdersFetched();

  @override
  List<Object> get props => [];
}
