import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/blocs/business/ride_order/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/nav_drawer.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';
import 'package:web_socket_channel/io.dart';

class NewRequest extends StatefulWidget {
  NewRequest({Key key}) : super(key: key);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  final _storage = new FlutterSecureStorage();
  BusinessRideOrdersBloc _rideOrdersBloc;
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _rideOrdersBloc = BlocProvider.of<BusinessRideOrdersBloc>(context);
    _getRideOrderUpdate();
  }

  _getRideOrderUpdate() async {
    final String jwtToken = await _storage.read(key: 'accessToken');
    var channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/delivery/ride-order/?token=$jwtToken");
    channel.stream.listen((response) {
      var decodedResponse = json.decode(response);
      if (decodedResponse['type'] == 'ride_processed') {
        Ride ride = Ride.fromMap(decodedResponse['ride_details']);
        _rideOrdersBloc.add(BusinessOrdersRemoved(ride));
      }
      if (decodedResponse['type'] == 'ride_orders') {
        Ride ride = Ride.fromMap(decodedResponse['ride_details']);
        _rideOrdersBloc.add(BusinessOrdersAdded(ride));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Ride Requests',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: 'Ubuntu')),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: BusinessNavDrawer(),
      body: RefreshIndicator(
          child: BlocBuilder<BusinessRideOrdersBloc, BusinessRideOrdersState>(
              // ignore: missing_return
              builder: (_, state) {
        if (state.isFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text("No orders!"),
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
        if (state.isSuccess) {
          if (state.rides.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("No orders!"),
                  alignment: Alignment.center,
                ),
              ],
            );
          }
          return ListView.builder(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            itemCount: state.hasReachedMax
                ? state.rides.length
                : state.rides.length + 1,
            padding: EdgeInsets.all(0.0),
            itemBuilder: (context, index) {
              if (index >= state.rides.length) {
                return PreLoader();
              }
              Ride ride = state.rides[index];
              return Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ride.distance + ' km' + '/' + ride.duration,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'Ubuntu')),
                        Text(getFullTime(ride.createdAt),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'Ubuntu')),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          margin: EdgeInsets.only(right: 8),
                          child: Text("From: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                        Flexible(
                          child: Text(ride.pickupLocation.address,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          margin: EdgeInsets.only(right: 8),
                          child: Text("To: ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                        Flexible(
                          child: Text(ride.deliveryLocation.address,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.7,
                        margin: EdgeInsets.only(top: 18),
                        color: Colors.grey[200]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(currencyFormatter.format(ride.price),
                            style:
                                TextStyle(color: Colors.black, fontSize: 13)),
                        InkWell(
                          child: Container(
                            height: 35,
                            padding: EdgeInsets.only(left: 30),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text("ASSIGN DRIVER",
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        color: AppColor.primaryText,
                                        fontFamily: 'Ubuntu',
                                        fontWeight: FontWeight.w500)),
                                SizedBox(width: 5),
                                Icon(Icons.arrow_forward_ios_outlined,
                                    color: AppColor.primaryText, size: 15)
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/AssignDriver/${ride.id}');
                          },
                          splashColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      }), onRefresh: () async {
        _rideOrdersBloc.add(BusinessOrdersReset());
        _rideOrdersBloc.add(BusinessOrdersFetched());
      }),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _rideOrdersBloc.add(BusinessOrdersFetched());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _rideOrdersBloc.add(BusinessOrdersReset());
    super.dispose();
  }
}
