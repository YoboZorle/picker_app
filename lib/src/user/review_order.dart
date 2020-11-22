import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/home.dart';
import 'package:pickrr_app/src/user/your_driver.dart';
import 'package:pickrr_app/src/values/values.dart';
import 'package:dotted_line/dotted_line.dart';

class ReviewOrder extends StatefulWidget {
  @override
  _ReviewOrderState createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {
  double amount = 500;
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Review Order',
              style: TextStyle(
                fontSize: 16,
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
            elevation: 0.5,
            backgroundColor: Colors.white,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SafeArea(
              child: Column(children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Stack(children: <Widget>[
                        ListView(
                            physics: const BouncingScrollPhysics(),
                            children: <Widget>[
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(width: 20),
                                    Text(
                                      'Transaction ID: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '87AGB346',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ]),
                              SizedBox(height: 25),
                              Container(
                                padding: EdgeInsets.only(left: 20, bottom: 8),
                                child: Row(
                                  children: [
                                    Transform.rotate(
                                      angle: 120,
                                      child: Icon(
                                        Icons.navigation_rounded,
                                        size: 22,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      'RECEIVER DETAILS',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: Text(
                                        'George Adowei',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      'Phone',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: Text(
                                        '08034233482',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: Text(
                                        '7B Sani Abacha road, Phase 3C, Port harcourt, Nigeria',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[300],
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20)),
                              Container(
                                padding: EdgeInsets.only(left: 20, bottom: 8),
                                child: Row(
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
                                        fontSize: 15,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: Text(
                                        'Cynthia Morgan',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      'Phone',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: Text(
                                        '07093432486',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Ubuntu",
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: Text(
                                        '3B Helmet Close, Port harcourt, Nigeria',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
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
                                        '33 mins',
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
                              SizedBox(height: 15),
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
                                        '6km',
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
                                  lineThickness: 0.5,
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
                                        currencyFormatter.format(amount),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: "Roboto",
                                            color: AppColors.primaryText,
                                            fontWeight: FontWeight.w700,
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
                          color: AppColors.primaryText,
                          child: Text("Pay " + currencyFormatter.format(amount),
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
            ),
          )),
    );
  }

  void _choosePaymentMethodSheet(context) {
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
                      margin: EdgeInsets.only(top: 15, bottom: 18),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
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
                      leading:
                      SvgPicture.asset('assets/svg/cash.svg',
                          height: 35, semanticsLabel: 'cash icon'),
                      title: new Text('Pay with Cash',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      onTap: () => {},
                    ),
                  ),
                  Divider(height: 0.5, color: Colors.grey[400]),
                  SizedBox(height: 15),
                  new ListTile(
                    dense: true,
                    leading:
                    SvgPicture.asset('assets/svg/card.svg',
                        height: 23, semanticsLabel: 'card icon'),
                    title: new Text('Pay Online',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Ubuntu",
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    onTap: () => {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
