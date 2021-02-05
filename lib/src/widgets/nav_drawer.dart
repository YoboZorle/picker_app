import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/screens/star_rating/rate_driver.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onTap: () => launch("tel://+2348076048409"),
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
                  !user.isDriver && !user.isBusiness
                      ? 'Become a rider'
                      : user.isDriver
                          ? 'Open as rider'
                          : 'Open as business',
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
                  if (user.isDriver) {
                    Navigator.pushNamed(
                      context,
                      '/DriversHomePage',
                    );
                    return;
                  }
                  if (user.isBusiness) {
                    Navigator.pushNamed(
                      context,
                      '/BusinessHomePage',
                    );
                    return;
                  }
                  Navigator.pushNamed(
                    context,
                    '/DriverOnboard',
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
                          'Driver profile',
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
                  Navigator.pushNamed(context, '/RiderHistory');
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
                onTap: () => launch("tel://+2348076048409"),
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

class BusinessNavDrawer extends StatelessWidget {
  final BusinessRepository _businessRepository = BusinessRepository();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 20.0,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (_, state) {
          if (state is NonLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.pushReplacementNamed(context, '/'));
          }
          if (state.props.isEmpty) {
            return Container();
          }
          User user = state.props[0];

          return FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.hasData == null ||
                  !snapshot.hasData) {
                return Container();
              }
              final businessDetails = snapshot.data;
              return ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.grey[300],
                    onTap: () {
                      Navigator.pushNamed(context, '/BusinessProfile');
                    },
                    child: UserAccountsDrawerHeader(
                      accountName: Text(businessDetails.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: 'Ubuntu',
                              height: 1.3)),
                      accountEmail: Text('Business account',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Ubuntu')),
                      currentAccountPicture: ClipOval(
                          child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(color: Colors.white),
                              child: businessDetails.logo != null
                                  ? CustomImage(
                                      imageUrl:
                                          '${businessDetails.logo}',
                                    )
                                  : Image.asset('placeholder.jpg',
                                      width: double.infinity,
                                      height: double.infinity))),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.grey[400],
                    ),
                    title: Text('Support',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Ubuntu')),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.star_rate_rounded,
                      color: Colors.grey[400],
                    ),
                    title: Text('Star rating',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Ubuntu')),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return RateDriver();
                            },
                            fullscreenDialog: true,
                          ));
                    },
                  ),
                  SizedBox(height: 35),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                    child: RaisedButton(
                        elevation: 12,
                        onPressed: () {
                          Navigator.pushNamed(context, '/HomePage');
                        },
                        color: AppColor.primaryText,
                        child: Container(
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text('Go back to Personal account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Ubuntu')),
                        )),
                  ),
                ],
              );
            },
            future: _businessRepository.getBusinessFromStorage(user.businessId),
          );
        }));
  }
}
