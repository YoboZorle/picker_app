import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';

class PackageReceiverDetails extends StatefulWidget {
  final double price;
  final Map<String, dynamic> pickupCoordinate;
  final Map<String, dynamic> destinationCoordinate;
  final String distance;
  final String duration;

  PackageReceiverDetails(
      {this.price,
      this.pickupCoordinate,
      this.destinationCoordinate,
      this.distance,
      this.duration});

  @override
  _PackageReceiverDetailsState createState() => _PackageReceiverDetailsState();
}

class _PackageReceiverDetailsState extends State<PackageReceiverDetails> {
  TextEditingController _receiversFullNameController;
  TextEditingController _receiversPhoneController;

  @override
  void initState() {
    _receiversFullNameController = new TextEditingController();
    _receiversPhoneController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              elevation: 0.5,
              title: Text('Provide Receiver Details',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Ubuntu",
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        height: 47,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        color: Colors.grey[200],
                        child:    Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 0),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              cursorColor: AppColor.primaryText,
                              controller: _receiversFullNameController,
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
                                suffixIcon: _receiversFullNameController.text != null &&
                                    _receiversFullNameController.text.isNotEmpty
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
                                        _receiversFullNameController.clear();
                                      });
                                    },
                                  ),
                                )
                                    : null,
                              ),
                            ),
                          ),
                        )),
                    ListTile(
                      leading: Icon(
                        Icons.person_pin,
                        color: Colors.grey[500],
                      ),
                      title: TextField(
                        controller: _receiversFullNameController,
                        decoration: InputDecoration(
                          hintText: "Receiver\'s full name",
                          hintStyle: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Ubuntu",
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              height: 1.35),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primaryText),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 20),
                      dense: true,
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(
                        Icons.phone_rounded,
                        color: Colors.grey[500],
                      ),
                      title: TextField(
                        controller: _receiversPhoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Receiver\'s phone number",
                          hintStyle: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Ubuntu",
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              height: 1.35),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primaryText),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 20),
                      dense: true,
                    ),
                    Expanded(child: SizedBox()),
                    Hero(
                      tag: "btn",
                      flightShuttleBuilder: flightShuttleBuilder,
                      child: InkWell(
                        child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 5, left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: _isFormValid()
                                  ? AppColor.primaryText
                                  : Colors.grey.withOpacity(0.5),
                              boxShadow: _isFormValid()
                                  ? [Shadows.secondaryShadow]
                                  : null,
                              borderRadius: Radii.kRoundpxRadius,
                            ),
                            child: Text('Continue',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500))),
                        onTap: () => _isFormValid()
                            ? Navigator.pushNamed(context, '/ReviewOrderPage',
                                arguments: RideDetailsArguments(
                                    widget.price,
                                    widget.pickupCoordinate,
                                    widget.destinationCoordinate,
                                    _receiversFullNameController.text,
                                    _receiversPhoneController.text,
                                    widget.distance,
                                    widget.duration))
                            : null,
                        splashColor: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  _isFormValid() =>
      _receiversFullNameController.text != null &&
      _receiversFullNameController.text.isNotEmpty &&
      _receiversPhoneController.text != null &&
      _receiversPhoneController.text.isNotEmpty;

  @override
  void dispose() {
    _receiversFullNameController.dispose();
    _receiversPhoneController.dispose();
    super.dispose();
  }
}
