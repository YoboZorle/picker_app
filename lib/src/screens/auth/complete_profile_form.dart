import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  final picker = ImagePicker();
  UserRepository _userRepository;

  PickedFile _profileImage;
  String _retrieveDataError;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _emailController = new TextEditingController();
    _fnameController = new TextEditingController();
    _userRepository = UserRepository();
    super.initState();
  }

  bool _hasCompletedForm() {
    return _emailController.text != null &&
        _emailController.text.isNotEmpty &&
        _fnameController.text != null &&
        _fnameController.text.isNotEmpty;
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
      Map<String, dynamic> formDetails = {
        'fullname': _fnameController.text,
        'email': _emailController.text,
      };

      if (_profileImage != null) {
        String fileName = _profileImage.path.split('/').last;
        formDetails['photo'] = await MultipartFile.fromFile(_profileImage.path,
            filename: fileName);
      }

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
          appBar: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Set Up Your Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Ubuntu',
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              )),
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
                            SizedBox(height: 25),
                            GestureDetector(
                              onTap: () async {
                                final pickedFile = await ImagePicker().getImage(
                                    imageQuality: 10,
                                    maxHeight: 500,
                                    maxWidth: 500,
                                    source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  setState(() {
                                    _profileImage = PickedFile(pickedFile.path);
                                  });
                                }
                              },
                              child: Column(
                                children: [
                                  !kIsWeb &&
                                          defaultTargetPlatform ==
                                              TargetPlatform.android
                                      ? FutureBuilder<void>(
                                          future: retrieveLostData(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<void> snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                              case ConnectionState.waiting:
                                                return ClipOval(
                                                    child: Image.asset(
                                                      'assets/images/placeholder.jpg',
                                                      fit: BoxFit.cover,
                                                      width: 90.0,
                                                      height: 90.0,
                                                    ));
                                              case ConnectionState.done:
                                                return _previewImage();
                                              default:
                                                if (snapshot.hasError) {
                                                  return Text(
                                                    'Pick image/video error: ${snapshot.error}}',
                                                    textAlign: TextAlign.center,
                                                  );
                                                } else {
                                                  return ClipOval(
                                                      child: Image.asset(
                                                        'assets/images/placeholder.jpg',
                                                        fit: BoxFit.cover,
                                                        width: 90.0,
                                                        height: 90.0,
                                                      ));
                                                }
                                            }
                                          },
                                        )
                                      : (_previewImage()),
                                  SizedBox(height: 16),
                                  Text('Upload photo',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
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
                    SizedBox(height: 5),
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

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _profileImage = response.file;
        });
      } else {
        return null;
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_profileImage != null) {
      if (kIsWeb) {
        return Image.network(_profileImage.path);
      } else {
        return ClipOval(
            child: Image.file(File(_profileImage.path),
                height: 90, width: 90, fit: BoxFit.cover));
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return ClipOval(
          child: Image.asset(
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
        width: 90.0,
        height: 90.0,
      ));
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
