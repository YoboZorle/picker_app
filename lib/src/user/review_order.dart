import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/user/your_driver.dart';
import 'package:dotted_line/dotted_line.dart';

class ReviewOrder extends StatefulWidget {
  @override
  _ReviewOrderState createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {
  double amount = 500;
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
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
                                        fontSize: 16,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Container(height: 33,
                                      margin: EdgeInsets.only(right: 20),
                                      child: RaisedButton(
                                        child: Text('COPY ID'),
                                        onPressed: () {
                                          final snackBar = SnackBar(
                                            content: Text('Transaction ID Copied!'),
                                            action: SnackBarAction(
                                              label: '87AGB346',
                                              textColor: Colors.yellowAccent,
                                              onPressed: () {},
                                            ),
                                          );
                                          _scaffoldKey.currentState.showSnackBar(snackBar);
                                        },
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 15),

                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Card(elevation: 100,
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
                                                '07034287783',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
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
                                                '24 Odilli road, Port harcourt, Nigeria',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "Ubuntu",
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600),
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
                                child: Card(elevation: 100,
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
                                        SizedBox(height: 3),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
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
                                        currencyFormatter.format(amount),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: "Roboto",
                                            color: AppColor.primaryText,
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
                          color: AppColor.primaryText,
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
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YourDriver()))
                      },
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
