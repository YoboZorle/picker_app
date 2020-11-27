import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/services/repositories/user.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _callingCode = '234';
  TextEditingController _phoneController;
  UserRepository _userRepository;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _phoneController = new TextEditingController();
    _userRepository = UserRepository();
    super.initState();
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
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 110),
                      Hero(
                        tag: 'input_phon_auth_title',
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
                      _terms(),
                      SizedBox(height: 25),
                      Container(
                          height: 47,
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          color: Colors.grey[200],
                          child: _phoneInput()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'An SMS code will be sent to you\nto verify your number',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
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
            _proceedBtn(),
          ]),
        ));
  }

  _phoneInput() => Container(
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
                      fontSize: 18.0,
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
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColor.primaryText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Ubuntu',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Mobile number',
                    hintStyle: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Ubuntu',
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: _phoneController.text != null &&
                            _phoneController.text.isNotEmpty
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

  _terms() => Container(
        margin: EdgeInsets.only(left: 20, top: 5),
        child: Hero(
          tag: 'body_text_splash',
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
                  recognizer: new TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      );

  _proceedBtn() => Container(
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
                onPressed: () => _processLogin(),
                color: AppColor.primaryText,
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

  _processLogin() async {
    if (_callingCode == null ||
        _callingCode.isEmpty ||
        _phoneController.text == null ||
        _phoneController.text.isEmpty) {
      AlertBar.dialog(context, 'Please provide requested details', Colors.red,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ),
          duration: 5);
      return;
    }

    AlertBar.dialog(
        context, 'Requesting Verification code...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      await _userRepository.requestOTP(
          callingCode: _callingCode, phone: _phoneController.text);
      Navigator.pop(context);
      _openEnterOTPScreen();
    } catch (err) {
      Navigator.pop(context);
      AlertBar.dialog(context, 'Request failed. please try again', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  _openEnterOTPScreen() {
    Navigator.pushNamed(
        context, '/OTPVerification/${_phoneController.text}/$_callingCode');
  }
}
