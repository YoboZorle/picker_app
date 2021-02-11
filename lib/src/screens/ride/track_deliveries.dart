import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/exceptions.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/utils/transitionAppbar/transition_appbar.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';

class TrackDeliveries extends StatefulWidget {
  @override
  _TrackDeliveriesState createState() => _TrackDeliveriesState();
}

class _TrackDeliveriesState extends State<TrackDeliveries> {
  TextEditingController _trackingIdController;
  RideRepository _rideRepository;
  bool _isTrackingFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    _trackingIdController = new TextEditingController();
    _rideRepository = RideRepository();
    _trackingIdController.addListener(() {
      setState(
          () => {_isTrackingFieldEmpty = _trackingIdController.text.isEmpty});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      controller: _trackingIdController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.black,
                      autofocus: false,
                      decoration: InputDecoration(
                          suffixIcon: _trackingIdController.text != null &&
                                  _trackingIdController.text.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 12.0),
                                  child: IconButton(
                                    iconSize: 16.0,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _trackingIdController.clear();
                                      });
                                    },
                                  ),
                                )
                              : null,
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
                        onPressed: () =>
                            _isTrackingFieldEmpty ? null : _getRideDetails(),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getRideDetails() async {
    final String rideId = _trackingIdController.text;
    if (rideId == null || rideId.isEmpty) return;
    AlertBar.dialog(context, 'Requesting ride details...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }
      var rideDetails = await _rideRepository.trackRide(rideId);
      Navigator.pop(context);
      Ride ride = Ride.fromMap(rideDetails);
      Navigator.pushNamed(context, '/RideDetails', arguments: RideArguments(ride));
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      if (err is ServiceError) {
        AlertBar.dialog(context, err.message, Colors.red,
            icon: Icon(Icons.error), duration: 5);
        return;
      }
      if (err is NotFoundError) {
        AlertBar.dialog(context, 'Tracking code does not match any delivery!', Colors.orange,
            icon: Icon(Icons.warning_amber_outlined), duration: 5);
        return;
      }
      AlertBar.dialog(context, 'Request could not be completed', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  @override
  void dispose() {
    _trackingIdController.dispose();
    super.dispose();
  }
}
