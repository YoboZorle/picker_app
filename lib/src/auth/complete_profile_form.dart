import 'dart:io';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickrr_app/src/home.dart';
import 'package:pickrr_app/src/values/values.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  TextEditingController _emailController;
  File _profileImage;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
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
                          child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                            Row(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 15.0),
                                    height: 30,
                                    width: 80,
                                    child: Text(
                                      'Skip',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Ubuntu',
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  onTap: (){

                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Text(
                              'Set Up Your Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Ubuntu',
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 45),
                            GestureDetector(
                              onTap: getImage,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      _profileImage == null
                                          ? ClipOval(
                                              child: Image.asset(
                                              'assets/images/placeholder.jpg',
                                              fit: BoxFit.cover,
                                              width: 95.0,
                                              height: 95.0,
                                            ))
                                          : ClipOval(
                                              child: Image.file(
                                              _profileImage,
                                              fit: BoxFit.cover,
                                              width: 95.0,
                                              height: 95.0,
                                            )),
                                      SizedBox(height: 18),
                                      Text('Upload photo',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Ubuntu',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  )),
                            ),
                            SizedBox(height: 25),
                            Container(
                                alignment: Alignment.center,
                                height: 55,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                color: Colors.grey[200],
                                child: emailInput()),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text('We\'ll send you your ride receipts.',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: 14)),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          height: 0.8,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey,
                                          margin: EdgeInsets.only(right: 20))),
                                  Text("OR",
                                      style: TextStyle(color: Colors.grey)),
                                  Expanded(
                                      child: Container(
                                          height: 0.8,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey,
                                          margin: EdgeInsets.only(left: 20))),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: SignInButton(
                                Buttons.Google,
                                text: "Continue with Google",
                                elevation: 20,
                                onPressed: () {},
                              ),
                            ),
                          ])),
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 46,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: FlatButton(
                        splashColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        // onPressed: _submitFormDetails,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Home()));
                        },
                        color: AppColors.primaryText,
                        child: Text("Continue",
                            style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                height: 1.4)),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ]),
          )),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  emailInput() => Container(
        margin: EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: AppColors.primaryText,
                  controller: _emailController,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Ubuntu',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Input email',
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
                    suffixIcon: _emailController.text.isNotEmpty
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
                                  _emailController.clear();
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
}
