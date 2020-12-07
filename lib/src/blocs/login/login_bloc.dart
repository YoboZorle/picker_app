import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/login/bloc.dart';
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
          phoneNumber: event.phoneNumber);
    }
  }

  Stream<LoginState> _mapLoginPressedToState({
    String otp,
    String callingCode,
    String phoneNumber
  }) async* {
    yield LoginState.loading();

    try {
      await _userRepository.otpVerification(
          otp: otp,
          callingCode: callingCode,
          phone: phoneNumber);
      yield LoginState.success();
    } catch (err) {
      yield LoginState.failure();
    }
  }
}
