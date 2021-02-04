import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/utils/country_code_picker.dart';
import 'package:pickrr_app/src/widgets/input.dart';

class NewRiderApplication extends StatefulWidget {
  @override
  _NewRiderApplicationState createState() => _NewRiderApplicationState();
}

class _NewRiderApplicationState extends State<NewRiderApplication> {
  PickedFile _profileImage;
  TextEditingController _fullnameController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  String _callingCode = '234';

  TextEditingController _plateNumberController;
  TextEditingController _ticketNumberController;
  TextEditingController _bikeBrandController;
  PickedFile _driversLicenceImage;
  final picker = ImagePicker();
  dynamic _imageUploadError;
  String _retrieveDataError;
  BusinessRepository _businessRepository;

  Future getDriversLicenceImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _driversLicenceImage = PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    _fullnameController = new TextEditingController();
    _phoneController = new TextEditingController();
    _emailController = new TextEditingController();

    _plateNumberController = new TextEditingController();
    _ticketNumberController = new TextEditingController();
    _bikeBrandController = new TextEditingController();
    _businessRepository = BusinessRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  'Register Rider',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
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
                                    _profileImage = PickedFile(pickedFile.path);
                                  });
                                }
                              },
                              child: Column(
                                children: [
                                  _previewProfileImage(),
                                  SizedBox(height: 16),
                                  Text('Profile photo',
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
                                child: InputField(
                                  inputController: _fullnameController,
                                  hintText: 'Driver Fullname',
                                  onPressed: () {
                                    setState(() {
                                      _fullnameController.clear();
                                    });
                                  },
                                )),
                            Container(
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputType: TextInputType.emailAddress,
                                  inputController: _emailController,
                                  hintText: 'Driver Email',
                                  onPressed: () {
                                    setState(() {
                                      _emailController.clear();
                                    });
                                  },
                                )),
                            Container(
                              height: 57,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              padding: EdgeInsets.all(10),
                              color: Colors.grey[200],
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 28,
                                    width: 85,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: new CountryCodePicker(
                                        onChanged: (value) {
                                          setState(() {
                                            final dialCode =
                                                value.dialCode.split('+');
                                            _callingCode = dialCode[1];
                                          });
                                        },
                                        flagWidth: 28,
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
                                          hintText: 'Driver\'s Mobile number',
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
                                          suffixIcon: _phoneController.text !=
                                                      null &&
                                                  _phoneController.text.isNotEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 12.0),
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
                            ),
                            Container(
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputController: _plateNumberController,
                                  hintText: 'Enter Plate Number',
                                  onPressed: () {
                                    setState(() {
                                      _plateNumberController.clear();
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
                                  inputController: _ticketNumberController,
                                  hintText: 'Enter Ticket Number',
                                  onPressed: () {
                                    setState(() {
                                      _ticketNumberController.clear();
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
                                  inputController: _bikeBrandController,
                                  hintText: 'Enter Brand of bike',
                                  onPressed: () {
                                    setState(() {
                                      _bikeBrandController.clear();
                                    });
                                  },
                                )),
                            Container(
                                alignment: Alignment.center,
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                color: Colors.grey[200],
                                child: GestureDetector(
                                  child: _driversLicenceImage == null
                                      ? Text(
                                          'Provide Drivers Licence(supported type: image).')
                                      : Text('Drivers licence selected'),
                                  onTap: getDriversLicenceImage,
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

  Widget _previewProfileImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_profileImage != null) {
      return ClipOval(
          child: Image.file(File(_profileImage.path),
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

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  _isFormValid() =>
      _driversLicenceImage != null &&
      _bikeBrandController.text != null &&
      _bikeBrandController.text.isNotEmpty &&
      _plateNumberController.text != null &&
      _plateNumberController.text.isNotEmpty &&
      _ticketNumberController.text != null &&
      _ticketNumberController.text.isNotEmpty &&
      _fullnameController.text != null &&
      _fullnameController.text.isNotEmpty &&
      _phoneController.text != null &&
      _phoneController.text.isNotEmpty &&
      _emailController.text != null &&
      _emailController.text.isNotEmpty;

  void _submitRequest() async {
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
        'fullname': _fullnameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'calling_code': _callingCode,

        'plate_number': _plateNumberController.text,
        'ticket_number': _ticketNumberController.text,
        'bike_brand': _bikeBrandController.text,
      };

      if (_profileImage != null) {
        String fileName = _profileImage.path.split('/').last;
        formDetails['photo'] = await MultipartFile.fromFile(_profileImage.path,
            filename: fileName);
      }

      String driverLicenceFileName = _driversLicenceImage.path.split('/').last;
      formDetails['drivers_licence'] = await MultipartFile.fromFile(
          _driversLicenceImage.path,
          filename: driverLicenceFileName);

      await _businessRepository
          .registerRider(new FormData.fromMap(formDetails));
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
    _plateNumberController.dispose();
    _ticketNumberController.dispose();
    _bikeBrandController.dispose();
    super.dispose();
  }
}
