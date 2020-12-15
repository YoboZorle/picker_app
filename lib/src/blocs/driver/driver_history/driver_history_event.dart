import 'package:equatable/equatable.dart';

abstract class DriverHistoryEvent extends Equatable {
  const DriverHistoryEvent();

  @override
  List<Object> get props => [];
}

class DriverHistoryReset extends DriverHistoryEvent {}

class DriverHistoryFetched extends DriverHistoryEvent {
  const DriverHistoryFetched();

  @override
  List<Object> get props => [];
}