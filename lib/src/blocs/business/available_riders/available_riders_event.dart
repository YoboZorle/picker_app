import 'package:equatable/equatable.dart';

abstract class AvailableRidersEvent extends Equatable {
  AvailableRidersEvent();
  @override
  List<Object> get props => [];
}

class RidersFetchReset extends AvailableRidersEvent {}

class RidersFetched extends AvailableRidersEvent {
  final String query;
  final bool isSearching;

  RidersFetched({this.query, this.isSearching = false});

  @override
  List<Object> get props => [query, isSearching];

  @override
  String toString() {
    return 'RidersFetched { query: $query, isSearching: $isSearching }';
  }
}
