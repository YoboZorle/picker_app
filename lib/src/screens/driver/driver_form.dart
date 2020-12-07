import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'package:pickrr_app/src/widgets/input.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

class DriverApplication extends StatefulWidget {
  @override
  _DriverApplicationState createState() => _DriverApplicationState();
}

class _DriverApplicationState extends State<DriverApplication> {
  TextEditingController _plateNumberController;
  TextEditingController _ticketNumberController;
  TextEditingController _companyNameController;
  DriverRepository _driverRepository;

  @override
  void initState() {
    _plateNumberController = new TextEditingController();
    _ticketNumberController = new TextEditingController();
    _companyNameController = new TextEditingController();
    _driverRepository = DriverRepository();
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
                            Text(
                              'Become A Pickrr',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Ubuntu',
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 45),
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
                                  inputController: _companyNameController,
                                  hintText: 'Enter Company Name',
                                  onPressed: () {
                                    setState(() {
                                      _companyNameController.clear();
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
                        onPressed: () => _submitDriverRequest(),
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
      _companyNameController.text != null &&
      _companyNameController.text.isNotEmpty &&
      _plateNumberController.text != null &&
      _plateNumberController.text.isNotEmpty &&
      _ticketNumberController.text != null &&
      _ticketNumberController.text.isNotEmpty;

  _submitDriverRequest() async {
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
        'plate_number': _plateNumberController.text,
        'ticket_number': _ticketNumberController.text,
        'company_name': _companyNameController.text,
      };

      await _driverRepository.driverRequest(new FormData.fromMap(formDetails));
      AlertBar.dialog(context,
          'Request has been sent. You will be contacted soon.', Colors.green,
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          duration: 10);
      Future.delayed(new Duration(seconds: 7), () {
        Navigator.pushReplacementNamed(context, '/');
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
    _companyNameController.dispose();
    super.dispose();
  }
}
