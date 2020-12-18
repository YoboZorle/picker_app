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

  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;

  @override
  void initState() {
    _receiversFullNameController = new TextEditingController();
    _receiversPhoneController = new TextEditingController();
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).popAndPushNamed('/HomePage');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text('Receiver Details',
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
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    onChanged: () => setState(
                        () => _enableBtn = _formKey.currentState.validate()),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.person_pin,
                            color: Colors.black,
                            size: 22,
                          ),
                          title: TextFormField(
                            autofocus: true,
                            validator: (value) => value.length < 5
                                ? 'Name must be at least 5 digits'
                                : null,
                            controller: _receiversFullNameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "Receiver\'s full name \*",
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
                                borderSide:
                                    BorderSide(color: AppColor.primaryText),
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(right: 20, left: 20),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          leading: Icon(
                            Icons.phone_rounded,
                            color: Colors.black,
                            size: 22,
                          ),
                          title: TextFormField(
                            validator: (value) => value.length < 10
                                ? 'Phone number must be ore than 10'
                                : null,
                            controller: _receiversPhoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Receiver\'s phone number \*",
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
                                borderSide:
                                    BorderSide(color: AppColor.primaryText),
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(right: 20, left: 20),
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
                                  color: _enableBtn
                                      ? AppColor.primaryText
                                      : Colors.grey.withOpacity(0.5),
                                  boxShadow: _enableBtn
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
                            onTap: () => _enableBtn
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
                ),
              ))),
    );
  }

  @override
  void dispose() {
    _receiversFullNameController.dispose();
    _receiversPhoneController.dispose();
    super.dispose();
  }
}
