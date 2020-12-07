import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/repositories/user.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  TextEditingController _fnameController;
  TextEditingController _emailController;
  File _profileImage;
  final picker = ImagePicker();
  UserRepository _userRepository;

  @override
  void initState() {
    _emailController = new TextEditingController();
    _fnameController = new TextEditingController();
    _userRepository = UserRepository();
    super.initState();
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  bool _hasCompletedForm() {
    return _emailController.text != null &&
        _emailController.text.isNotEmpty &&
        _fnameController.text != null &&
        _fnameController.text.isNotEmpty &&
        _profileImage != null;
  }

  updateProfileDetailsHandler() async {
    if (!_hasCompletedForm()) {
      AlertBar.dialog(
          context, 'Please provide requested information', Colors.red,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ),
          duration: 5);
      return;
    }

    AlertBar.dialog(context, 'Saving information...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      String fileName = _profileImage.path.split('/').last;
      Map<String, dynamic> formDetails = {
        'fullname': _fnameController.text,
        'email': _emailController.text,
        'photo':
            await MultipartFile.fromFile(_profileImage.path, filename: fileName)
      };

      await _userRepository
          .updateProfileDetails(new FormData.fromMap(formDetails));
      Navigator.pushReplacementNamed(context, '/HomePage');
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, 'Request failed. please try again', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
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
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Stack(children: <Widget>[
                      SafeArea(
                          child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                            Text(
                              'Set Up Your Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
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
                                              width: 90.0,
                                              height: 90.0,
                                            ))
                                          : ClipOval(
                                              child: Image.file(
                                              _profileImage,
                                              fit: BoxFit.cover,
                                              width: 90.0,
                                              height: 90.0,
                                            )),
                                      SizedBox(height: 18),
                                      Text('Upload photo',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Ubuntu',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  )),
                            ),
                            SizedBox(height: 25),
                            Container(
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                color: Colors.grey[200],
                                child: _fullNameInput()),
                            Container(
                                alignment: Alignment.center,
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                color: Colors.grey[200],
                                child: _emailInput()),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text('We\'ll send you your ride receipts.',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: 13)),
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
                        onPressed: () => updateProfileDetailsHandler(),
                        color: AppColor.primaryText,
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
    _fnameController.dispose();
    _emailController.dispose();
    _fnameController.dispose();
    super.dispose();
  }

  _fullNameInput() => Container(
        margin: EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  cursorColor: AppColor.primaryText,
                  controller: _fnameController,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Ubuntu',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Enter full name',
                    hintStyle: TextStyle(
                        fontSize: 16.0,
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

  _emailInput() => Container(
        margin: EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: AppColor.primaryText,
                  controller: _emailController,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Ubuntu',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Input email',
                    hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Ubuntu',
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: _emailController.text != null &&
                            _emailController.text.isNotEmpty
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
