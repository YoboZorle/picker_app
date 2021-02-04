import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/widgets/input.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

class BusinessApplication extends StatefulWidget {
  @override
  _BusinessApplicationState createState() => _BusinessApplicationState();
}

class _BusinessApplicationState extends State<BusinessApplication> {
  TextEditingController _nameController;
  TextEditingController _locationController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  BusinessRepository _businessRepository;
  PickedFile _businessLogo;
  dynamic _imageUploadError;
  String _retrieveDataError;

  @override
  void initState() {
    _nameController = new TextEditingController();
    _locationController = new TextEditingController();
    _phoneController = new TextEditingController();
    _emailController = new TextEditingController();
    _businessRepository = BusinessRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading:    IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:   Text(
            'Business account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Ubuntu',
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
                            SizedBox(height: 45),
                            GestureDetector(
                              onTap: () async {
                                final pickedFile = await ImagePicker().getImage(
                                    imageQuality: 10,
                                    maxHeight: 500,
                                    maxWidth: 500,
                                    source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  setState(() {
                                    _businessLogo = PickedFile(pickedFile.path);
                                  });
                                }
                              },
                              child: Column(
                                children: [
                                  _previewImage(),
                                  SizedBox(height: 16),
                                  Text('Business logo',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputController: _nameController,
                                  hintText: 'Business Name',
                                  onPressed: () {
                                    setState(() {
                                      _nameController.clear();
                                    });
                                  },
                                )),
                            Container(
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputController: _locationController,
                                  hintText: 'Enter State/City',
                                  onPressed: () {
                                    setState(() {
                                      _locationController.clear();
                                    });
                                  },
                                )),
                            Container(
                                alignment: Alignment.center,
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputController: _phoneController,
                                  hintText: 'Enter Phone Number',
                                  onPressed: () {
                                    setState(() {
                                      _phoneController.clear();
                                    });
                                  },
                                )),
                            Container(
                                alignment: Alignment.center,
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputController: _emailController,
                                  hintText: 'Enter Business Email Address',
                                  onPressed: () {
                                    setState(() {
                                      _emailController.clear();
                                    });
                                  },
                                )),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                  'We\'ll contact you as soon as your request is received.',
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
                        onPressed: () => _submitRequest(),
                        color: AppColor.primaryText,
                        child: Text("Submit Request",
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
            ])));
  }

  _isFormValid() =>
      _nameController.text != null &&
      _nameController.text.isNotEmpty &&
      _locationController.text != null &&
      _locationController.text.isNotEmpty &&
      _phoneController.text != null &&
      _phoneController.text.isNotEmpty &&
      _emailController.text != null &&
      _emailController.text.isNotEmpty;

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_businessLogo != null) {
      return ClipOval(
          child: Image.file(File(_businessLogo.path),
              height: 90, width: 90, fit: BoxFit.cover));
    } else if (_imageUploadError != null) {
      return Text(
        'Pick image error: $_imageUploadError',
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

  _submitRequest() async {
    if (!_isFormValid()) {
      AlertBar.dialog(
          context, 'Please provide requested information', Colors.red,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ),
          duration: 5);
      return;
    }

    AlertBar.dialog(context, 'Submitting request...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      Map<String, dynamic> formDetails = {
        'name': _nameController.text,
        'location': _locationController.text,
        'phone': _phoneController.text,
        'email': _emailController.text
      };

      if (_businessLogo != null) {
        String fileName = _businessLogo.path.split('/').last;
        formDetails['logo'] = await MultipartFile.fromFile(_businessLogo.path,
            filename: fileName);
      }

      await _businessRepository
          .applicationRequest(new FormData.fromMap(formDetails));
      AlertBar.dialog(context,
          'Request has been sent. You will be contacted soon.', Colors.green,
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          duration: 10);
      Future.delayed(new Duration(seconds: 7), () {
        Navigator.pushReplacementNamed(context, '/BusinessHomePage');
      });
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
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
