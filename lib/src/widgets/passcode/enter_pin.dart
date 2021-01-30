import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/utils/show_up_animation.dart';
import 'package:pinput/pin_put/pin_put.dart';

class EnterPinWidget extends StatefulWidget {
  final String nextRoute;

  EnterPinWidget({@required this.nextRoute});

  @override
  EnterPinWidgetState createState() => EnterPinWidgetState();
}

class EnterPinWidgetState extends State<EnterPinWidget> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final BusinessRepository _businessRepository = BusinessRepository();
  final int delayAmount = 500;

  BoxDecoration get _pinDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColor.primaryText),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: EdgeInsets.only(top: 45, right: 20, left: 20),
                        child: Stack(children: <Widget>[
                          ListView(physics: BouncingScrollPhysics(), children: <
                              Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ShowUp(
                                    child: BlocBuilder<AuthenticationBloc,
                                            AuthenticationState>(
                                        builder: (_, state) {
                                      if (state is NonLoggedIn) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) =>
                                                Navigator.pushReplacementNamed(
                                                    context, '/'));
                                      }
                                      if (state.props.isEmpty) {
                                        return Container();
                                      }
                                      User user = state.props[0];
                                      return Text(
                                          'Welcome back ${user.fullname},\nenter your PIN',
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 20,
                                              height: 1.36,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700));
                                    }),
                                    delay: delayAmount + 600,
                                  ),
                                ),
                                ShowUp(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: SvgPicture.asset(
                                        'assets/svg/pickrr.svg',
                                        color: Colors.grey[300],
                                        height: 55,
                                        semanticsLabel: 'search icon'),
                                  ),
                                  delay: delayAmount + 1000,
                                ),
                              ],
                            ),
                            ShowUp(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 30.0, bottom: 25),
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: PinPut(
                                      fieldsCount: 5,
                                      eachFieldHeight: 55,
                                      focusNode: _pinFocusNode,
                                      controller: _pinController,
                                      onSubmit: (String pin) =>
                                          _processRequest(),
                                      submittedFieldDecoration:
                                          _pinDecoration.copyWith(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      selectedFieldDecoration: _pinDecoration,
                                      followingFieldDecoration:
                                          _pinDecoration.copyWith(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: AppColor.primaryText
                                              .withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              delay: delayAmount + 1200,
                            ),
                            ShowUp(
                              delay: delayAmount + 1400,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 30,
                                      child: Text(
                                        'Forgot login PIN?',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: "Ubuntu",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          letterSpacing: 0.0,
                                          color: AppColor.primaryText,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      _requestForgotPin();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ])),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isPinValid() =>
      this._pinController.text != null && this._pinController.text.isNotEmpty;

  _processRequest() async {
    if (!_isPinValid()) {
      AlertBar.dialog(
          context, 'Please enter your pin and re-enter it again.', Colors.red,
          icon: Icon(Icons.error), duration: 5);
      return;
    }
    try {
      AlertBar.dialog(context, 'Processing request...', AppColor.primaryText,
          showProgressIndicator: true, duration: null);
      Map<String, dynamic> formDetails = {'pin': _pinController.text};
      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection, and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
      }
      await _businessRepository.verifyPin(FormData.fromMap(formDetails));
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      Navigator.pushNamedAndRemoveUntil(
          context, widget.nextRoute, (route) => false);
    } catch (err) {
      cprint(err.message);
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  _requestForgotPin() async {
    try {
      AlertBar.dialog(context, 'Processing request...', AppColor.primaryText,
          showProgressIndicator: true, duration: null);
      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection, and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
      }
      await _businessRepository.forgotPin();
      Navigator.pop(context);
      AlertBar.dialog(
          context,
          'Your pin has been sent to your business e-mail address.',
          Colors.green,
          duration: 6);
    } catch (err) {
      cprint(err.message);
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
