import 'package:equatable/equatable.dart';

abstract class BusinessRideHistoryEvent extends Equatable {
  const BusinessRideHistoryEvent();

  @override
  List<Object> get props => [];
}

class BusinessRideHistoryReset extends BusinessRideHistoryEvent {}

class BusinessRideHistoryFetched extends BusinessRideHistoryEvent {
  final int riderId;

  const BusinessRideHistoryFetched(this.riderId);

  @override
  List<Object> get props => [];
}
