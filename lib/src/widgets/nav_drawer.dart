import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/user.dart';
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
      if (state.props.isEmpty) {
        return Container();
      }
      User user = state.props[0];

      return SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(children: <Widget>[
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/ProfileDetails');
              },
              child: Row(
                children: [
                  ClipOval(
                      child: Container(
                          height: 65.0,
                          width: 65.0,
                          child: !user.noProfileImage
                              ? CustomImage(
                                  imageUrl:
                                      '${APIConstants.assetsUrl}${user.profileImageUrl}',
                                )
                              : Image.asset('placeholder.jpg',
                                  width: double.infinity,
                                  height: double.infinity))),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullname,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Ubuntu",
                            fontSize: 18),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'View profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Ubuntu",
                            height: 1.5,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                height: 0.7,
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300]),
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
                Navigator.pushNamed(context, '/RideHistory');
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
              leading: Icon(Icons.help_outline),
              onTap: () {},
            ),
            ListTile(
                title: Text(
                  'Legal Policy',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Ubuntu",
                      fontSize: 18),
                ),
                leading: Icon(Icons.verified_user_outlined),
                onTap: () {
                  Navigator.pushNamed(context, '/Terms');
                }),
            Expanded(child: SizedBox()),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.primaryText,
              ),
              margin: EdgeInsets.only(bottom: 40),
              child: ListTile(
                title: Text(
                  !user.isDriver ? 'Become a rider' : 'Open as rider',
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
                  if (!user.isDriver) {
                    Navigator.pushNamed(
                      context,
                      '/DriverOnboard',
                    );
                    return;
                  }
                  Navigator.pushNamed(
                    context,
                    '/DriversHomePage',
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

class RiderNavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
          if (state is NonLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback(
                    (_) => Navigator.pushReplacementNamed(context, '/'));
          }
          if (state.props.isEmpty) {
            return Container();
          }
          User user = state.props[0];
          return Drawer(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(children: <Widget>[
                  SizedBox(height: 30),
                  ListTile(
                    leading: ClipOval(
                        child: Container(
                          height: 65.0,
                          width: 65.0,
                          child: !user.noProfileImage
                              ? CustomImage(
                            imageUrl:
                            '${APIConstants.assetsUrl}${user.profileImageUrl}',
                          ): Image.asset('placeholder.jpg',
                              width: double.infinity, height: double.infinity),
                        )),
                    title: Text(
                      user.fullname,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Ubuntu",
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      'Driver profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Ubuntu",
                          fontSize: 15),
                    ),
                  ),
                  Container(
                      height: 0.7,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[300]),
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
                        'Back to user',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Ubuntu",
                            color: Colors.white,
                            fontSize: 16),
                      ),
                      subtitle: Text(
                        'Go back to ordering rides',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Ubuntu",
                            color: Colors.grey[200],
                            fontSize: 15),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          size: 17, color: Colors.grey[200]),
                      onTap: () {
                        Navigator.pushNamed(context, '/HomePage');
                      },
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
