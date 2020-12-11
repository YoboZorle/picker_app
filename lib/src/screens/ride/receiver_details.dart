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
      {this.price, this.pickupCoordinate, this.destinationCoordinate, this.distance, this.duration});

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
            body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Container(),
                SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 15, 16, 8),
                      child: Hero(
                        tag: "nav",
                        flightShuttleBuilder: flightShuttleBuilder,
                        child: GestureDetector(
                            child: Container(
                              // color: Colors.yellow,
                              padding: EdgeInsets.only(right: 10),
                              child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 23,
                                    ),
                                  )),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      )),
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  Shadows.primaryShadow,
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 8,
                    width: 60,
                    margin: EdgeInsets.only(top: 15, bottom: 18),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  new Text(
                    "Provide Receiver Details",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Ubuntu",
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        height: 1.35),
                  ),
                  SizedBox(height: 10),
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
                  Hero(
                    tag: "btn",
                    flightShuttleBuilder: flightShuttleBuilder,
                    child: InkWell(
                      child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              bottom: 18, left: 25, right: 25, top: 30),
                          decoration: BoxDecoration(
                            color: _isFormValid()
                                ? AppColor.primaryText
                                : Colors.grey.withOpacity(0.5),
                            boxShadow: _isFormValid() ? [Shadows.secondaryShadow] : null,
                            borderRadius: Radii.kRoundpxRadius,
                          ),
                          child: Text('Continue',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500))),
                      onTap: () => _isFormValid()
                          ? Navigator.pushNamed(
                              context, '/ReviewOrderPage',
                              arguments: RideDetailsArguments(
                                  widget.price,
                                  widget.pickupCoordinate,
                                  widget.destinationCoordinate,
                                  _receiversFullNameController.text,
                                  _receiversPhoneController.text, widget.distance, widget.duration))
                          : null,
                      splashColor: Colors.grey[300],
                    ),
                  ),
                ],
              )),
        ],
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
