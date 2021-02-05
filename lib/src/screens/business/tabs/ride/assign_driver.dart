import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/business/available_riders/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';

class AssignDriver extends StatefulWidget {
  final int rideId;

  AssignDriver(this.rideId);

  @override
  _AssignDriverState createState() => _AssignDriverState();
}

class _AssignDriverState extends State<AssignDriver> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  AvailableRidersBloc _availableRidersBloc;
  final BusinessRepository _businessRepository = BusinessRepository();
  String query;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _availableRidersBloc = BlocProvider.of<AvailableRidersBloc>(context);
    _availableRidersBloc.add(RidersFetched());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _availableRidersBloc.add(RidersFetchReset());
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: new AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined,
                    color: Colors.black, size: 22),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: new Text("Choose Driver",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
          ),
          body: new Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: new Column(
              children: <Widget>[
                _searchWidget(),
                _driverWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return new Container(
      decoration:
          BoxDecoration(border: Border.all(width: 0.3, color: Colors.black)),
      child: new TextField(
        autofocus: true,
        onChanged: (text) {
          setState(() => query = text);
          _availableRidersBloc
              .add(RidersFetched(query: query, isSearching: true));
        },
        decoration: InputDecoration(
          hintText: "Search your drivers",
          hintStyle: new TextStyle(
              color: Colors.grey[400],
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
              fontSize: 15),
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }

  Widget _driverWidget() {
    return new Flexible(child:
        BlocBuilder<AvailableRidersBloc, AvailableRidersState>(
            builder: (blocContext, state) {
      if (state.isFailure) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("No riders!"),
              alignment: Alignment.center,
            ),
          ],
        );
      }
      if (state.isInitial || !state.isSuccess && state.isLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            ),
          ],
        );
      }
      return state.isSuccess
          ? new ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: state.hasReachedMax
                  ? state.drivers.length
                  : state.drivers.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index >= state.drivers.length) {
                  return PreLoader();
                }
                Driver rider = state.drivers[index];
                return new Card(
                  color: Colors.white,
                  elevation: 0.05,
                  child: new ListTile(
                      onTap: () async => _chooseRider(rider.id),
                      leading: ClipOval(
                          child: Container(
                              height: 38.0,
                              width: 38.0,
                              decoration: BoxDecoration(color: Colors.white),
                              child: rider.details.profileImageUrl != null ||
                                      rider.details.profileImageUrl.isNotEmpty
                                  ? CustomImage(
                                      imageUrl:
                                          '${rider.details.profileImageUrl}',
                                    )
                                  : Image.asset('placeholder.jpg',
                                      width: double.infinity,
                                      height: double.infinity))),
                      title: new Text(rider.details.fullname,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                              fontSize: 15)),
                      subtitle: new Text('Online',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.grey[300], size: 20),
                      contentPadding: EdgeInsets.only(left: 15, right: 5)),
                );
              })
          : Container();
    }));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _availableRidersBloc.add(RidersFetchReset());
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _availableRidersBloc.add(RidersFetched(isSearching: false, query: query));
    }
  }

  void _chooseRider(int riderId) async {
    try {
      AlertBar.dialog(context, 'Processing request...', AppColor.primaryText,
          showProgressIndicator: true, duration: null);
      Map<String, dynamic> formDetails = {
        'rider_id': riderId,
        'ride_id': widget.rideId
      };
      if (!await isInternetConnected()) {
        Navigator.pop(context);
        AlertBar.dialog(context,
            'Please check your internet connection, and try again.', Colors.red,
            icon: Icon(Icons.error), duration: 5);
      }
      await _businessRepository
          .assignRiderToRide(FormData.fromMap(formDetails));
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      Navigator.popAndPushNamed(context, '/DriverActivities/$riderId');
    } catch (err) {
      cprint(err.message);
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }
}
