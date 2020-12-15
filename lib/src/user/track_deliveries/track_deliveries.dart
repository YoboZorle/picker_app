import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/utils/transitionAppbar/transition_appbar.dart';

class TrackDeliveries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            TransitionAppBar(
              extent: 100,
              avatar: Text("Track Deliveries",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Ubuntu',
                    fontSize: 25,
                  )),
              title: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.black,
                      autofocus: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          hintText: "Enter tracking ID",
                          border: InputBorder.none,
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(2),
                          )),
                    ),
                  ),
                ]),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 8, left: 8),
                          child: Text('Track',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w600)),
                        ),
                        color: AppColor.primaryText,
                        textColor: AppColor.primaryText,
                        onPressed: () {},
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(child: Text("Tracked deliveries appear here")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
