import 'package:equatable/equatable.dart';

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