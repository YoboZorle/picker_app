import 'package:equatable/equatable.dart';

abstract class DriverWalletHistoryEvent extends Equatable {
  const DriverWalletHistoryEvent();

  @override
  List<Object> get props => [];
}

class DriverWalletHistoryReset extends DriverWalletHistoryEvent {}

class DriverWalletHistoryFetched extends DriverWalletHistoryEvent {
  final int riderId;

  const DriverWalletHistoryFetched(this.riderId);

  @override
  List<Object> get props => [];
}
