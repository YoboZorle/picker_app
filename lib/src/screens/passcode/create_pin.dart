import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/screens/driver/onboard.dart';
import 'package:pickrr_app/src/screens/onboard.dart';
import 'package:pickrr_app/src/screens/passcode/enter_pin.dart';
import 'package:pinput/pin_put/pin_put.dart';

class CreatePin extends StatefulWidget {
  @override
  CreatePinState createState() => CreatePinState();
}

class CreatePinState extends State<CreatePin> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

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
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            elevation: 0,
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
                        ListView(
                          physics: BouncingScrollPhysics(),
                            children: <Widget>[
                            Text('Enter New PIN',
                                style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0, bottom: 30),
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  child: PinPut(
                                    fieldsCount: 5,
                                    eachFieldHeight: 55,
                                    onSubmit: (String pin) =>
                                        _showSnackBar(pin, context),
                                    focusNode: _pinPutFocusNode,
                                    controller: _pinPutController,
                                    submittedFieldDecoration:
                                        _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    selectedFieldDecoration: _pinPutDecoration,
                                    followingFieldDecoration:
                                        _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AppColor.primaryText.withOpacity(.5),
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
                                  margin: const EdgeInsets.only(top: 8.0, bottom: 20),
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  child: PinPut(
                                    fieldsCount: 5,
                                    eachFieldHeight: 55,
                                    onSubmit: (String pin) =>
                                        _showSnackBar(pin, context),
                                    focusNode: _pinPutFocusNode,
                                    controller: _pinPutController,
                                    submittedFieldDecoration:
                                        _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    selectedFieldDecoration: _pinPutDecoration,
                                    followingFieldDecoration:
                                        _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: AppColor.primaryText.withOpacity(.5),
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
            'Pin values: $pin and $pin',
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
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => EnterPin()));
          },
        ),
      );
}
