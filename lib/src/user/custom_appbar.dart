import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickrr_app/src/auth/otp_verification.dart';
import 'package:pickrr_app/src/values/values.dart';

class CustomerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 15, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: "nav",
                flightShuttleBuilder: _flightShuttleBuilder,
                child: GestureDetector(
                    child: Container(
                      // color: Colors.yellow,
                      padding: EdgeInsets.only(right: 10),
                      child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.menu_sharp,
                              size: 23,
                            ),
                          )),
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                      // _scaffoldKey.currentState.openDrawer();
                    }),
              ),
              GestureDetector(
                child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primaryText,
                      boxShadow: [Shadows.secondaryShadow],
                      borderRadius: Radii.k25pxRadius,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        SvgPicture.asset('assets/svg/kargo_bike.svg',
                            height: 22, semanticsLabel: 'Bike Icon'),
                        SizedBox(width: 8),
                        Text('Become a rider',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        SizedBox(width: 15),
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OTPVerification(authId: null)),
                  );
                },
              ),

            ],
          )),
    );
  }

  Widget _flightShuttleBuilder(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
      ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }
}