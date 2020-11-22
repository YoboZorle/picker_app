import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/values/values.dart';
import 'package:pin_view/pin_view.dart';

import 'complete_profile_form.dart';

class OTPVerification extends StatelessWidget {
  String _poseGirl = "pose";
  String _authId;

  OTPVerification({@required authId}){
    this._authId = authId;
  }

  final SmsListener smsListener = SmsListener(
      from: '6505551212', //sms phone number
      formatBody: (String body) {
        String codeRaw = body.split(": ")[1]; //seperator befpre pin
        List<String> code = codeRaw.split("-");
        return code.join();
      });

  Widget pinViewWithSms(BuildContext context) {
    return PinView(
        count: 5,
        autoFocusFirstField: false,
        enabled: true,
        sms: smsListener,
        submit: (String pin) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Pin received successfully."),
                    content: Text("Entered pin is: $pin"));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                          Text('Input the verification code sent to $_authId',
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
                                    style: TextStyle(color: Colors.black, fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Send again',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Ubuntu',
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {}),
                                    ]),
                              )),
                          SizedBox(height: 10),
                        ])),
                  ])),
            ),
            proceedBtn(context),
          ]),
        ));
  }

  proceedBtn(BuildContext context) => Container(
    margin: EdgeInsets.only(top: 7, bottom: 7),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 46,
          width: MediaQuery.of(context).size.width / 1.1,
          child: FlatButton(
            splashColor: Colors.grey[200],
            color: AppColors.primaryText,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteProfileForm()),
              );
            },
            child: Text("Verify code",
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.4)),
          ),
        ),
        SizedBox(height: 15),
      ],
    ),
  );

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
