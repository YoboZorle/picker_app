import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/blocs/login/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/repositories/user.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pin_view/pin_view.dart';

class OTPVerification extends StatelessWidget {
  final String phone;
  final String callingCode;
  final UserRepository _userRepository = UserRepository();

  OTPVerification({@required this.phone, @required this.callingCode});

  final SmsListener smsListener = SmsListener(
      from: AppData.messageFrom,
      formatBody: (String body) {
        String codeRaw = body.split(": ")[1];
        debugLog('OTP: $codeRaw');
        return codeRaw;
      });

  Widget pinViewWithSms(BuildContext context) {
    return PinView(
        count: 5,
        autoFocusFirstField: false,
        enabled: true,
        sms: smsListener,
        submit: (String pin) => _requestOTPVerification(pin, context: context));
  }

  _requestOTPVerification(String pin, {BuildContext context}) {
    AlertBar.dialog(context, 'Requesting...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);
    try {
      BlocProvider.of<LoginBloc>(context).add(
        LoginSubmitted(
            otp: pin.toString(),
            callingCode: callingCode,
            phoneNumber: phone),
      );
    } catch (err) {
      Navigator.pop(context);
      debugLog(err);
    }
  }

  _loginHandler(BuildContext context, LoginState state) {
    if (state.isFailure) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Request failed. Please try again.', Colors.red,
          icon: Icon(Icons.error, color: Colors.red), duration: 5);
    } else if (state.isLoading) {
      AlertBar.dialog(context, 'Login in...', AppColor.primaryText,
          showProgressIndicator: true, duration: null);
    } else if (state.isSuccess) {
      BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEvent.AUTHENTICATED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (_, state) async {
            _loginHandler(context, state);
          },
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (__, state) {
            if (state is LoggedIn) {
              User user = state.props[0];

              if (!user.isCompleteDetails) {
                Navigator.pushReplacementNamed(context, '/CompleteProfileDetails');
                return;
              }

              if(user.isDriver){
                Navigator.pushReplacementNamed(context, '/DriversHomePage');
              }

              Navigator.pushReplacementNamed(context, '/HomePage');
            }
          },
        )
      ],
      child: new Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Stack(children: <Widget>[
                      SafeArea(
                          child: ListView(children: <Widget>[
                        hintText(),
                        SizedBox(height: 8),
                        Text(
                            'Input the verification code sent to +$callingCode${phone.replaceAll(RegExp(r'.(?=.{4})'), '*')}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.7,
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            )),
                        Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.only(left: 50, right: 50, top: 25),
                            child: pinViewWithSms(context)),
                        SizedBox(height: 25),
                        Text('I didn\'t receive a verification code!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.7,
                              fontFamily: 'Ubuntu',
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                            )),
                        SizedBox(height: 4),
                        Center(
                            child: RichText(
                          text: TextSpan(
                              text: '',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Send again',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Ubuntu',
                                        color: AppColor.primaryText,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _sendOTPRequest(context);
                                      }),
                              ]),
                        )),
                        SizedBox(height: 10),
                      ])),
                    ])),
              ),
            ]),
          )),
    );
  }

  void _sendOTPRequest(context) async {
    AlertBar.dialog(
        context, 'Requesting Verification code...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      await _userRepository.requestOTP(callingCode: callingCode, phone: phone);
      Navigator.pop(context);
    } catch (err) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Request failed. please try again', Colors.red,
          icon: Icon(Icons.error, color: Colors.red), duration: 5);
    }
  }

  hintText() => Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(
          'Pickrr Activation Code',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Ubuntu',
            color: Colors.black,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
      );
}
