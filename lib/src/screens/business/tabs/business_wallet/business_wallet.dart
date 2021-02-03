import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/screens/business/tabs/ride_requests/new_request.dart';

class BusinessWallet extends StatelessWidget {
  final String title;

  BusinessWallet({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('My Wallet',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Ubuntu')),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Row(
              children: [
                RaisedButton(
                    elevation: 8,
                    onPressed: () {},
                    color: AppColor.primaryText,
                    child: Text('Withdraw',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Ubuntu'))),
                SizedBox(width: 20)
              ],
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer:  BusinessDrawer(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              new Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('Earnings',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.green)),
                              Text('N2,400.00',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Debts',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red)),
                              Text('N400.00',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Transactions',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Ubuntu'),
                      )
                    ],
                  )),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 500,
                  itemBuilder: (context, index) {
                    return Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Text('Some text'));
                  })
            ],
          ),
        ));
  }
}
