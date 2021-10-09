import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:spring_button/spring_button.dart';

class Onboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          brightness: Brightness.light,
          leading: Container(),
          elevation: 0,
          toolbarHeight: 30,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent),
      body: Stack(
        children: [
          Container(height: 2, width: MediaQuery.of(context).size.width),
          Positioned.fill(
            bottom: -15,
            right: -200,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image(
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 1.9,
                image: AssetImage('assets/images/onboard_finder.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                ShowUpAnimation(
                  delayStart: Duration(milliseconds: 500),
                  animationDuration: Duration(milliseconds: 500),
                  curve: Curves.bounceInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Hero(
                    tag: 'input_phon_auth_title',
                    flightShuttleBuilder: _flightShuttleBuilder,
                    child: Text(
                      "Hi SkootEat,\nBye Stress!",
                      style: TextStyle(
                        color: AppColor.appBlack,
                        fontSize: 32,
                        height: 1.3,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                ShowUpAnimation(
                  delayStart: Duration(milliseconds: 700),
                  animationDuration: Duration(milliseconds: 700),
                  curve: Curves.bounceInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Container(
                      height: 6,
                      width: 50,
                      color: AppColor.appTealBlue,
                      margin: EdgeInsets.only(top: 20, bottom: 20)),
                ),
                ShowUpAnimation(
                  delayStart: Duration(milliseconds: 1000),
                  animationDuration: Duration(milliseconds: 1000),
                  curve: Curves.bounceInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Text(
                    "Find Food Delivery Guys\nNearest To You.",
                    style: TextStyle(
                      color: AppColor.appBlack,
                      fontSize: 18,
                      height: 1.43,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ShowUpAnimation(
                  delayStart: Duration(milliseconds: 1300),
                  animationDuration: Duration(milliseconds: 1300),
                  curve: Curves.bounceInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: SpringButton(
                    SpringButtonType.OnlyScale,
                    Container(
                      height: 52,
                      width: 185,
                      decoration: new BoxDecoration(
                        color: AppColor.appYellow,
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(18)),
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            color: AppColor.appBlack,
                            fontSize: 16,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    useCache: true,
                    onTapUp: (_) {
                      Navigator.pushNamed(context, '/Login');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flightShuttleBuilder(
    BuildContext context,
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
