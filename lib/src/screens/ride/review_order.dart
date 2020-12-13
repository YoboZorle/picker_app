import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

class ReviewOrder extends StatelessWidget {
  final RideDetailsArguments arguments;
  final RideRepository _rideRepository = RideRepository();

  ReviewOrder(this.arguments);

  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          brightness: Brightness.light,
          title: Text(
            'Review Order',
            style: TextStyle(
              fontSize: 17,
              fontFamily: 'Ubuntu',
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (_, state) {
            if (state is NonLoggedIn) {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Navigator.pushReplacementNamed(context, '/'));
            }
            if (state.props.isEmpty) {
              return Container();
            }
            User user = state.props[0];

            return SafeArea(
              child: Column(children: <Widget>[
                Expanded(
                  child: new Container(
                      color: Colors.grey[100],
                      margin: EdgeInsets.only(top: 5),
                      child: Stack(children: <Widget>[
                        ListView(
                            physics: const BouncingScrollPhysics(),
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 10),
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_rounded,
                                              size: 22,
                                              color: Colors.redAccent,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              'SENDER DETAILS',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Ubuntu',
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "Ubuntu",
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(width: 18),
                                            Expanded(
                                              child: Text(
                                                user.fullname.capitalize(),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Text(
                                              'Phone',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "Ubuntu",
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(width: 18),
                                            Expanded(
                                              child: Text(
                                                '+${user.callingCode}${user.phone}',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Address',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "Ubuntu",
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(width: 18),
                                            Expanded(
                                              child: Text(
                                                arguments.pickupCoordinate[
                                                        'address'] ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Transform.rotate(
                                              angle: 120,
                                              child: Icon(
                                                Icons.navigation_rounded,
                                                size: 22,
                                                color: Colors.green,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              'RECEIVER DETAILS',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Ubuntu',
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "Ubuntu",
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(width: 18),
                                            Expanded(
                                              child: Text(
                                                arguments.receiversFullName
                                                    .capitalize(),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Text(
                                              'Phone',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "Ubuntu",
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(width: 18),
                                            Expanded(
                                              child: Text(
                                                arguments.receiversPhone,
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Address',
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "Ubuntu",
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(width: 18),
                                            Expanded(
                                              child: Text(
                                                arguments.destinationCoordinate[
                                                        'address'] ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Estimated Delivery Time:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        arguments.duration,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ]),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Distance in Kilometers:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '${arguments.distance} km',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ]),
                              ),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.5,
                                  dashLength: 5.0,
                                  dashColor: Colors.grey,
                                  dashRadius: 0.0,
                                  dashGapLength: 5.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Total Delivery Cost:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      new Text(
                                        currencyFormatter
                                            .format(arguments.price),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: "Roboto",
                                            color: AppColor.primaryText,
                                            fontWeight: FontWeight.w800,
                                            height: 1.35),
                                      ),
                                    ]),
                              ),
                            ]),
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => YourDriver()));

                            _choosePaymentMethodSheet(context);
                          },
                          color: AppColor.primaryText,
                          child: Text(
                              "Pay " +
                                  currencyFormatter.format(arguments.price),
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 15,
                                  height: 1.4)),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ]),
            );
          }),
        ));
  }

  void _choosePaymentMethodSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new Wrap(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 8,
                      width: 60,
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: Text('Choose Payment Method',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                height: 1.35)),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: new ListTile(
                      dense: true,
                      leading: SvgPicture.asset('assets/svg/cash.svg',
                          height: 30, semanticsLabel: 'cash icon'),
                      title: new Text('Pay with Cash',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 20),
                      onTap: () => _processOrder(context, 'CASH'),
                    ),
                  ),
                  Divider(height: 0.5, color: Colors.grey[400]),
                  SizedBox(height: 15),
                  new ListTile(
                    dense: true,
                    leading: SvgPicture.asset('assets/svg/card.svg',
                        height: 30, semanticsLabel: 'card icon'),
                    title: new Text('Pay Online',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: "Ubuntu",
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    onTap: () => {},
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 20),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
  }

  void _processOrder(BuildContext context, String paymentMethod) async {
    AlertBar.dialog(context, 'Processing request...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      Map<String, dynamic> formDetails = {
        'price': arguments.price,
        'duration': arguments.duration,
        'distance': arguments.distance,
        'receiver_phone': arguments.receiversPhone,
        'receiver_name': arguments.receiversFullName,
        'pickup_location': arguments.pickupCoordinate['id'],
        'delivery_location': arguments.destinationCoordinate['id'],
        'payment_method': paymentMethod
      };

      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }

      var rideDetails = await _rideRepository.processRideOrder(new FormData.fromMap(formDetails));
      Ride ride = Ride.fromMap(rideDetails);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/RideDetails', arguments: RideArguments(ride));
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }
}
