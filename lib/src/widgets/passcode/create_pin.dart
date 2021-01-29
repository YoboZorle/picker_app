import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pinput/pin_put/pin_put.dart';

class CreatePinWidget extends StatefulWidget {
  final String nextRoute;

  CreatePinWidget({@required this.nextRoute});

  @override
  CreatePinWidgetState createState() => CreatePinWidgetState();
}

class CreatePinWidgetState extends State<CreatePinWidget> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final TextEditingController _retypedPinController = TextEditingController();
  final FocusNode _retypedPinFocusNode = FocusNode();
  final BusinessRepository _businessRepository = BusinessRepository();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColor.primaryText),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          brightness: Brightness.light,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text('Create PIN',
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
          centerTitle: true),
      body: GestureDetector(
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
                      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: Stack(children: <Widget>[
                        ListView(physics: BouncingScrollPhysics(), children: <
                            Widget>[
                          Text('Enter New PIN',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 8.0, bottom: 30),
                                width: MediaQuery.of(context).size.width / 1.6,
                                child: PinPut(
                                  fieldsCount: 5,
                                  eachFieldHeight: 55,
                                  onSubmit: (String pin) =>
                                      _validateAndSubmitPin(),
                                  focusNode: _pinFocusNode,
                                  controller: _pinController,
                                  submittedFieldDecoration:
                                      _pinPutDecoration.copyWith(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  selectedFieldDecoration: _pinPutDecoration,
                                  followingFieldDecoration:
                                      _pinPutDecoration.copyWith(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color:
                                          AppColor.primaryText.withOpacity(.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text('Re enter PIN',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Container(
                                color: Colors.white,
                                margin:
                                    const EdgeInsets.only(top: 8.0, bottom: 20),
                                width: MediaQuery.of(context).size.width / 1.6,
                                child: PinPut(
                                  fieldsCount: 5,
                                  eachFieldHeight: 55,
                                  onSubmit: (String pin) =>
                                      _validateAndSubmitPin(),
                                  focusNode: _retypedPinFocusNode,
                                  controller: _retypedPinController,
                                  submittedFieldDecoration:
                                      _pinPutDecoration.copyWith(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  selectedFieldDecoration: _pinPutDecoration,
                                  followingFieldDecoration:
                                      _pinPutDecoration.copyWith(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color:
                                          AppColor.primaryText.withOpacity(.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                              'This code will be required whenever you try to access your account.',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  color: AppColor.grey,
                                  fontWeight: FontWeight.w400)),
                        ]),
                      ])),
                ),
                _continueBtn(),
              ],
            );
          },
        ),
      ),
    );
  }

  _continueBtn() => Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 8),
        child: GestureDetector(
          child: Container(
            height: 47,
            decoration: BoxDecoration(
              color: AppColor.primaryText,
              borderRadius: const BorderRadius.all(
                Radius.circular(35.0),
              ),
            ),
            child: Center(
              child: Text(
                'Continue',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: 0.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onTap: () {},
        ),
      );

  _validateAndSubmitPin() {
    print('IN here');
    print('Pin one: ${_pinController.text}');
    print('Pin two: ${_retypedPinController.text}');
  }

  _processRequest() async {
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
      await _businessRepository.createPin(FormData.fromMap(formDetails));
    } catch (err) {
      cprint(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }
}
