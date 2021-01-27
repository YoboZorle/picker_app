import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/screens/passcode/enter_pin.dart';
import 'package:pickrr_app/src/widgets/input.dart';

class ForgotPin extends StatefulWidget {
  @override
  ForgotPinState createState() => ForgotPinState();
}

class ForgotPinState extends State<ForgotPin> {


  TextEditingController _forgotEmailController;


  @override
  void initState() {
    _forgotEmailController = new TextEditingController();
    super.initState();
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
            brightness: Brightness.light,
            elevation: .5,
            title: Text('Forgot PIN',
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
                                Text('Enter the email address tied to your\naccount',
                                    style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),

                                Container(
                                    height: 47,
                                    margin: EdgeInsets.only(
                                    right: 20, bottom: 20, top: 15),
                                    color: Colors.grey[200],
                                    child: InputField(
                                      inputController: _forgotEmailController,
                                      hintText: 'youremail@here.com',
                                      onPressed: () {
                                        setState(() {
                                          _forgotEmailController.clear();
                                        });
                                      },
                                    )),

                                Text(
                                    'Your PIN will be sent to your email',
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
