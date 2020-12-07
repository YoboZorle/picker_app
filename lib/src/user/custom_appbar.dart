import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

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
                    }),
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (_, state) {
                if (state is NonLoggedIn) {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => Navigator.pushReplacementNamed(context, '/'));
                }
                if (state.props.isEmpty) {
                  return Container();
                }
                User user = state.props[0];
                print('Hello from this side');
                print(user);
                print(user.isDriver);
                print('----cosing -------');
                return GestureDetector(
                  child: Container(
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.primaryText,
                        boxShadow: [Shadows.secondaryShadow],
                        borderRadius: Radii.k25pxRadius,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          SvgPicture.asset('assets/svg/kargo_bike.svg',
                              height: 20, semanticsLabel: 'Bike Icon'),
                          SizedBox(width: 8),
                          user.isDriver ? Text('Open as rider',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)) : Text('Become a rider',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(width: 15),
                        ],
                      )),
                  onTap: () {
                    if(!user.isDriver){
                      Navigator.pushNamed(
                        context,
                        '/DriverOnboard',
                      );
                      return;
                    }
                    Navigator.pushNamed(
                      context,
                      '/DriverOnboard',
                    );
                  },
                );
              }),
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
