import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String otp;
  final String callingCode;
  final String phoneNumber;
  final String deviceToken;

  const LoginSubmitted(
      {this.otp, this.callingCode, this.phoneNumber, this.deviceToken});

  @override
  List<Object> get props => [otp, callingCode, phoneNumber, deviceToken];

  @override
  String toString() {
    return 'LoginPressed { otp: $otp, callingCode: $callingCode, phoneNumber: $phoneNumber, deviceToken: $deviceToken }';
  }
}
