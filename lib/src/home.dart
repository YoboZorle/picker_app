/*
*  main_widget.dart
*  Pickrr
*
*  Created by Yobo Zorle.
*  Copyright © 2020 Klynox. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'values/values.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 199,
              height: 63,
              margin: EdgeInsets.only(left: 44, top: 64),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 89,
                      height: 63,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        border: Border.fromBorderSide(Borders.primaryBorder),
                        borderRadius: Radii.k15pxRadius,
                      ),
                      child: Container(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 89,
                      height: 63,
                      margin: EdgeInsets.only(left: 21),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryBackground,
                      ),
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 187,
              height: 66,
              margin: EdgeInsets.only(left: 44, top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 89,
                      height: 63,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackground,
                        boxShadow: [
                          Shadows.primaryShadow,
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Yes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(left: 38, top: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        border: Border.fromBorderSide(Borders.primaryBorder),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}