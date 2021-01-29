import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/utils/show_up_animation.dart';
import 'package:pinput/pin_put/pin_put.dart';

class EnterPinWidget extends StatefulWidget {
  final String nextRoute;

  EnterPinWidget({@required this.nextRoute});

  @override
  EnterPinWidgetState createState() => EnterPinWidgetState();
}

class EnterPinWidgetState extends State<EnterPinWidget> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final int delayAmount = 500;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColor.primaryText),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                            ListView(
                                physics: BouncingScrollPhysics(),
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ShowUp(
                                        child: Text(
                                            'Welcome back Yobo,\nenter your PIN',
                                            style: TextStyle(
                                                fontFamily: 'Ubuntu',
                                                fontSize: 20,
                                                height: 1.36,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700)),
                                        delay: delayAmount + 600,
                                      ),
                                      ShowUp(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.6,
                                          child: PinPut(
                                            fieldsCount: 5,
                                            eachFieldHeight: 55,
                                            onSubmit: (String pin) =>
                                                _showSnackBar(pin, context),
                                            focusNode: _pinPutFocusNode,
                                            controller: _pinPutController,
                                            submittedFieldDecoration:
                                                _pinPutDecoration.copyWith(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            selectedFieldDecoration:
                                                _pinPutDecoration,
                                            followingFieldDecoration:
                                                _pinPutDecoration.copyWith(
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
                                          onTap: () {},
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
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 25.0,
        child: Center(
          child: Text(
            'Pin value: $pin',
            style: const TextStyle(fontSize: 13.0),
          ),
        ),
      ),
      backgroundColor: AppColor.primaryText,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
