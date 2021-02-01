import 'package:flutter/material.dart';

class BusinessWallet extends StatelessWidget {
  final String title;
  BusinessWallet({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
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
                      Text('Transactions',
                      style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w400, fontFamily: 'Ubuntu'),)
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
