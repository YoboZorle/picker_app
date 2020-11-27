import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/driver/driver_onboard.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/user/ride_history/ride_history.dart';
import 'package:pickrr_app/src/user/track_deliveries/track_deliveries.dart';
import 'package:pickrr_app/src/widgets/image.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
      if (state is NonLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pushReplacementNamed(context, '/'));
      }
      User user = state.props[0];
      return SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(children: <Widget>[
            SizedBox(height: 30),
            ListTile(
              leading: ClipOval(
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    child: CustomImage(
                      imageUrl:
                      '${APIConstants.assetsUrl}${user.profileImageUrl}',
                    ),
                  )),
              title: Text(
                user.fullname,
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrackDeliveries()),
                );
              },
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RideHistory()),
                );
              },
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
                color: AppColor.primaryText,
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
                    MaterialPageRoute(builder: (context) => DriverBoard()),
                  );
                },
              ),
            )
          ]),
        ),
      );
    });
  }
}
