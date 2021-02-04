import 'package:equatable/equatable.dart';

abstract class BusinessRidersEvent extends Equatable {
  BusinessRidersEvent();
  @override
  List<Object> get props => [];
}

class RidersFetchReset extends BusinessRidersEvent {}

class RidersFetched extends BusinessRidersEvent {
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
