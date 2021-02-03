import 'package:equatable/equatable.dart';

abstract class BusinessTransactionEvent extends Equatable {
  const BusinessTransactionEvent();

  @override
  List<Object> get props => [];
}

class BusinessTransactionReset extends BusinessTransactionEvent {}

class BusinessTransactionFetched extends BusinessTransactionEvent {
  const BusinessTransactionFetched();

  @override
  List<Object> get props => [];
}
