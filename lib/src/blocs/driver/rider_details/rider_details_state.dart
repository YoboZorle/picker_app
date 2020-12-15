import 'package:equatable/equatable.dart';

abstract class RiderDetailsState extends Equatable {
  const RiderDetailsState();

  @override
  List<Object> get props => [];
}

class IsRiding extends RiderDetailsState {}

class RiderIsOk extends RiderDetailsState {}

class IsBlocked extends RiderDetailsState {}