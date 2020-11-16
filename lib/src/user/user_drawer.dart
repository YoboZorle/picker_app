import 'package:flutter/material.dart';
import 'package:pickrr_app/src/auth/otp_verification.dart';
import 'package:pickrr_app/src/values/values.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(children: <Widget>[
          SizedBox(height: 30),
          ListTile(
            leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80")),
            title: Text(
              'David Ejiro',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Ubuntu",
                  fontSize: 18),
            ),
            subtitle: Text(
              'Edit profile',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Ubuntu",
                  height: 1.5,
                  fontSize: 14),
            ),
          ),
          Container(
              height: 0.7,
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300]),
          ListTile(
            title: Text(
              'Track Deliveries',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Ubuntu",
                  fontSize: 18),
            ),
            leading: Icon(Icons.track_changes),
            dense: false,
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Order History',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Ubuntu",
                  fontSize: 18),
            ),
            leading: Icon(Icons.history),
          ),
          ListTile(
            title: Text(
              'Support',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Ubuntu",
                  fontSize: 18),
            ),
            leading: Icon(Icons.support_agent),
          ),
          ListTile(
            title: Text(
              'About',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Ubuntu",
                  fontSize: 18),
            ),
            leading: Icon(Icons.read_more),
          ),
          Expanded(child: SizedBox()),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryText,
            ),
            margin: EdgeInsets.only(bottom: 40),
            child: ListTile(
              title: Text(
                'Become a rider',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Ubuntu",
                    color: Colors.white,
                    fontSize: 16),
              ),
              subtitle: Text(
                'Earn money on your schedule',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "Ubuntu",
                    color: Colors.grey[200],
                    fontSize: 13),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  size: 17, color: Colors.grey[200]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPVerification(authId: null)),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
