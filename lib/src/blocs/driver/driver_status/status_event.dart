import 'package:equatable/equatable.dart';

class DriverStatusEvent extends Equatable {
  const DriverStatusEvent();

  @override
  List<Object> get props => [];
}

class StatusUpdated extends DriverStatusEvent {
  final String status;

  const StatusUpdated({this.status});

  @override
  List<Object> get props => [status];

  @override
  String toString() {
    return 'StatusUpdated { status: $status }';
  }
}
