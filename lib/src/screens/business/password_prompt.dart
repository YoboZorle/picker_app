import 'package:flutter/material.dart';
import 'package:pickrr_app/src/widgets/passcode/create_pin.dart';
import 'package:pickrr_app/src/widgets/passcode/enter_pin.dart';

class PasswordPrompt extends StatelessWidget {
  final bool isNewBusiness;
  final String nextRoute;

  PasswordPrompt(this.isNewBusiness, {this.nextRoute = '/BusinessHome'});

  @override
  Widget build(BuildContext context) {
    if (isNewBusiness) {
      return CreatePinWidget(nextRoute: nextRoute);
    }
    return EnterPinWidget(nextRoute: nextRoute);
  }
}
