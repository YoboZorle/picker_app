import 'package:equatable/equatable.dart';

abstract class BusinessStatusState extends Equatable {
  const BusinessStatusState();

  @override
  List<Object> get props => [];
}

class RiderIsOk extends BusinessStatusState {}

class IsBlocked extends BusinessStatusState {}
