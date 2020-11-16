import 'package:flutter/material.dart';
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
              'Complete Order',
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
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Receiver\'s Details',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [Shadows.secondaryShadow8],
                                  borderRadius: Radii.kRoundpxRadius8,
                                ),
                                padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
                                child: ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            height: 1.6),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'George Adowei',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Ubuntu',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ]),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: 'Phone: ',
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: "Ubuntu",
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                height: 1.6),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '08034233482',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ]),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Address: ',
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: "Ubuntu",
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                height: 1.6),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '7B Sani Abacha road, GRA Phase 3C, Port harcourt, Nigeria',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ]),
                                      ),

                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  dense: true,
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Sender\'s Details',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [Shadows.secondaryShadow8],
                                  borderRadius: Radii.kRoundpxRadius8,
                                ),
                                padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
                                child: ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: "Ubuntu",
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                            height: 1.6),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Blessing Christopher',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Ubuntu',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ]),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      RichText(
                                        text: TextSpan(
                                            text: 'Phone: ',
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: "Ubuntu",
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                height: 1.6),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '09074222382',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ]),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Address: ',
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: "Ubuntu",
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400,
                                                height: 1.6),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                '49 Nembe street, Borikiri, Port harcourt, Nigeria',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(0),
                                  dense: true,
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
                                          fontSize: 13,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '33 mins',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 13,
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
                                          fontSize: 13,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '6km',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 13,
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
                                          fontSize: 13,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YourDriver()));
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
}
