import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:pickrr_app/src/values/values.dart';

import 'otp_verification.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> with TickerProviderStateMixin {
  TextEditingController _fnameController;
  TextEditingController _phoneController;
  String _callingCode = '234';
  bool _phoneNumberProvided = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _fnameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _phoneController = new TextEditingController();
    _fnameController = new TextEditingController();
    _phoneController.addListener(() {
      setState(() => {_phoneNumberProvided = _phoneController.text.isNotEmpty});
    });
    _fnameController.addListener(() {
      setState(() => {_phoneNumberProvided = _phoneController.text.isNotEmpty});
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
                  margin: EdgeInsets.only(top: 5, right: 10, left: 10),
                  child: Stack(children: <Widget>[
                    SafeArea(
                        child: ListView(children: <Widget>[
                      Row(
                        children: [
                          GestureDetector(
                            child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 15.0),
                                      height: 40,
                                      width: 100,
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                          SizedBox(height: 110),
                          Hero(tag: 'input_phon_auth_title',
                            child: Container(
                              margin: EdgeInsets.only(left: 22),
                              child: Text(
                                'Let\'s Get Started!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                          terms(),
                          SizedBox(height: 25),
                          Container(
                              height: 55,
                              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              color: Colors.grey[200],
                              child: fullName()),
                          Container(height: 55,
                              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              color: Colors.grey[200],
                              child: phoneInput()),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'An SMS code will be sent to you\nto verify your number',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ])),
                  ])),
            ),
            proceedBtn(),
          ]),
        ));
  }

  phoneInput() => Container(
    margin: EdgeInsets.only(left: 15),
    child: Row(
      children: <Widget>[
        Container(
          height: 30,
          width: 110,
          child: Align(
            alignment: Alignment.centerLeft,
            child: new CountryCodePicker(
              onChanged: (value) {
                setState(() {
                  final dialCode = value.dialCode.split('+');
                  _callingCode = dialCode[1];
                });
              },
              initialSelection: 'NG',
              favorite: ['+234', 'NG'],
              showCountryOnly: true,
              alignLeft: true,
              textStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              keyboardType: TextInputType.number,
              cursorColor: AppColors.primaryText,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              controller: _phoneController,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: 'Mobile number',
                hintStyle: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Ubuntu',
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: _phoneController.text.isNotEmpty
                    ? Padding(
                  padding:
                  const EdgeInsetsDirectional.only(start: 12.0),
                  child: IconButton(
                    iconSize: 16.0,
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _phoneController.clear();
                      });
                    },
                  ),
                )
                    : null,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  fullName() => Container(
    margin: EdgeInsets.only(left: 15),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              cursorColor: AppColors.primaryText,
              controller: _fnameController,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: 'Enter full name',
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Ubuntu',
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: _fnameController.text.isNotEmpty
                    ? Padding(
                  padding:
                  const EdgeInsetsDirectional.only(start: 12.0),
                  child: IconButton(
                    iconSize: 16.0,
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _fnameController.clear();
                      });
                    },
                  ),
                )
                    : null,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  terms() => Container(
    margin: EdgeInsets.only(left: 20, top: 5),
    child: Hero(tag: 'body_text_splash',
      child: new RichText(
        textAlign: TextAlign.left,
        text: new TextSpan(
          children: [
            new TextSpan(
              text: 'By entering your details, you agree to\ Pickrr\'s ',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Ubuntu',
                color: Colors.black,
                fontWeight: FontWeight.w400,
                height: 1.27,
              ),
            ),
            new TextSpan(
              text: 'terms of service.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Ubuntu',
                color: Colors.black,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w400,
                height: 1.27,
              ),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                },
            ),
          ],
        ),
      ),
    ),
  );

  proceedBtn() => Container(
    margin: EdgeInsets.only(top: 7, bottom: 7),
    child: Column(
      children: <Widget>[
      SizedBox(
            height: 46,
            width: MediaQuery.of(context).size.width / 1.1,
            child: FlatButton(
              splashColor: Colors.grey[200],
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPVerification(_callingCode, _phoneController.text)),
                );
              },
              color: AppColors.primaryText,
              child: Text("Send code",
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
}
