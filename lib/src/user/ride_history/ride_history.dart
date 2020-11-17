import 'package:flutter/material.dart';

class RideHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Order History',
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
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10),
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: ListTile(
                        title: Text(
                          'Aggrey Road 7',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              height: 1.6),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '17/11/2020, 6:49 AM',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                            ),
                            Text(
                              'SCHEDULED',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: ListTile(
                        title: Text(
                          'Sani Abacha Road 5',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              height: 1.6),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '16/11/2020, 6:49 PM',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                            ),
                            Text(
                              'RIDE FINISHED',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: ListTile(
                        title: Text(
                          'Hospital Road 4',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              height: 1.6),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '14/11/2020, 6:26 PM',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                            ),
                            Text(
                              'YOU CANCELLED',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
