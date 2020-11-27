import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/login/bloc.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/repositories/user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc()
      : _userRepository = UserRepository(),
        super(LoginState.empty());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield* _mapLoginPressedToState(
          otp: event.otp,
          callingCode: event.callingCode,
          phoneNumber: event.phoneNumber,
          deviceToken: event.deviceToken);
    }
  }

  Stream<LoginState> _mapLoginPressedToState({
    String otp,
    String callingCode,
    String phoneNumber,
    String deviceToken,
  }) async* {
    yield LoginState.loading();

    try {
      await _userRepository.otpVerification(
          otp: otp,
          callingCode: callingCode,
          phone: phoneNumber,
          deviceToken: deviceToken);
      yield LoginState.success();
    } catch (err) {
      debugLog(err);
      yield LoginState.failure();
    }
  }
}
