import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/utils/pinput/pin_put.dart';
import 'package:pickrr_app/src/values/values.dart';


class OTPVerification extends StatefulWidget {
  final String phone;
  final String callingCode;

  OTPVerification(this.callingCode, this.phone);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 0;
  String securedPhoneNumber;

  @override
  void initState() {
    super.initState();
    _pinPutFocusNode.requestFocus();
    // securedPhoneNumber = widget.phone.replaceAll(RegExp(r'.(?=.{4})'), '*');
  }

  @override
  void dispose() {
    _pinPutFocusNode.dispose();
    super.dispose();
  }

  Widget onlySelectedBorderPinPut() {
    BoxDecoration pinPutDecoration = BoxDecoration(
      color: Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(5),
    );
    return PinPut(
      fieldsCount: 5,
      textStyle:
      TextStyle(fontSize: 25, fontFamily: 'Ubuntu', color: Colors.black),
      eachFieldWidth: 40,
      eachFieldHeight: 50,
      onSubmit: (String pin) => (pin),
      focusNode: _pinPutFocusNode,
      autofocus: true,
      controller: _pinPutController,
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration.copyWith(
          color: Colors.white,
          border: Border.all(
            width: 1.5,
            color: AppColors.primaryText,
          )),
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.slide,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pinPuts = [
      onlySelectedBorderPinPut(),
    ];

    List<Color> _bgColors = [
      Colors.white,
      Color.fromRGBO(43, 36, 198, 1),
      Colors.white,
      Color.fromRGBO(75, 83, 214, 1),
      Color.fromRGBO(43, 46, 66, 1),
    ];

    return new Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(fit: StackFit.passthrough, children: <Widget>[
            AnimatedContainer(
              color: _bgColors[_pageIndex],
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(40),
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                children: _pinPuts.map((p) {
                  return FractionallySizedBox(
                    heightFactor: 1,
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 50),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text(
                                'Enter your\nverification code',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            bodyOTP(),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 15), child: p),
                          ],
                        )),
                  );
                }).toList(),
              ),
            ),
            resendOTP(),
          ]),
        ));
  }

  bodyOTP() => Container(
    margin: EdgeInsets.only(bottom: 30),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'We sent a verification code to ',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Ubuntu',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          children: <TextSpan>[
            TextSpan(
              // text: '+${widget.callingCode}',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Ubuntu',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
            TextSpan(
              text: securedPhoneNumber,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Ubuntu',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            )
          ]),
    ),
  );

  resendOTP() => Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Did not receive code?',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Ubuntu',
                color: Colors.black,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: ' Send again',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Ubuntu',
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {})
              ]),
        ),
      ));
}
