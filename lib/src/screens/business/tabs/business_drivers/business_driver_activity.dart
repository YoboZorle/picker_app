import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_drivers/business_driver_details.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessDriverActivity extends StatefulWidget {
  BusinessDriverActivityWidget createState() => BusinessDriverActivityWidget();
}

class BusinessDriverActivityWidget extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                centerTitle: true,
                title: Text(
                  'Ride Activity',
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10),
                    Card(
                      elevation: 0,
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://i.pinimg.com/originals/3d/4a/5a/3d4a5a8be9cbf58c91b9933022d147c9.jpg")))),
                              title: Text(
                                "Chinanza Orji",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6),
                              ),
                              subtitle: Text(
                                '6.3km/9mins ride',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              ),
                              trailing: Text('N400.00',
                                  style: TextStyle(
                                      color: Color(0xFF16B9BB),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Ubuntu')),
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Text("From: ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w400)),
                                ),
                                Flexible(
                                  child: Text(
                                      '20 Egbema Street, Borikiri, Port harcourt, Nigeria',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Text("To: ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w400)),
                                ),
                                Flexible(
                                  child: Text(
                                      '66-4 Parkhurst Rd, Chelmsford MA 1824 ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 0.7,
                                margin: EdgeInsets.only(top: 18, bottom: 10),
                                color: Colors.grey[200]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(top: 5, right: 50),
                                    decoration: BoxDecoration(
                                      borderRadius: Radii.kRoundpxRadius,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.phone_in_talk_rounded,
                                              color: Colors.black, size: 19),
                                          SizedBox(width: 8),
                                          Text('Call 08038752226',
                                              style: TextStyle(
                                                  fontSize: 13.3,
                                                  fontFamily: 'Ubuntu',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () => launch("tel://+2348038752226"),
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  color: AppColor.primaryText,
                                  textColor: AppColor.primaryText,
                                  padding: EdgeInsets.only(left: 25, right: 25),
                                  onPressed: () {},
                                  child: Text("ACCEPT RIDE",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.white,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15),
                          child: ListTile(
                            leading: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://bloximages.chicago2.vip.townnews.com/stlamerican.com/content/tncms/assets/v3/editorial/1/cb/1cb65068-c76d-11e8-8686-7f40e5fbe1d0/5bb5605309dba.image.jpg?resize=400%2C422")))),
                            title: Text(
                              "Amadi Chibuzor",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6),
                            ),
                            subtitle: Text(
                              'View your driver details',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_outlined,
                                color: Colors.grey[300], size: 20),
                            contentPadding: EdgeInsets.all(0),
                            dense: true,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                                return BusinessDriverDetails();
                              },
                              fullscreenDialog: true,
                            ));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
