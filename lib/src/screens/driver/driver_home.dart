import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/blocs/driver/rider_details/bloc.dart';
import 'package:pickrr_app/src/blocs/ride/orders/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/widgets/driver_appbar.dart';
import 'package:pickrr_app/src/widgets/nav_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';
import 'package:pickrr_app/src/widgets/driver_ride_details_dialog.dart';
import 'package:web_socket_channel/io.dart';

class DriverHome extends StatefulWidget {
  DriverHome({Key key}) : super(key: key);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<Position> _positionStream;
  final DriverRepository _driverRepository = DriverRepository();
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  final _storage = new FlutterSecureStorage();
  RideOrdersBloc _rideOrdersBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _rideOrdersBloc = BlocProvider.of<RideOrdersBloc>(context);
    _updateDriverPosition();
    _getNewRideOrder();
  }

  _updateDriverPosition() async {
    final String jwtToken = await _storage.read(key: 'accessToken');
    var channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/drivers/update-location/?token=$jwtToken");
    _positionStream =
        Geolocator.getPositionStream().listen((Position position) {
      if (position != null) {
        channel.sink.add(json
            .encode({'lat': position.latitude, 'long': position.longitude}));
      }
    });
  }

  _getNewRideOrder() async {
    final String jwtToken = await _storage.read(key: 'accessToken');
    var channel = IOWebSocketChannel.connect(
        "${APIConstants.wsUrl}/ws/delivery/ride-order/?token=$jwtToken");
    channel.stream.listen((response) {
      var decodedResponse = json.decode(response);
      if (decodedResponse['update_type'] == 'ride_processed') {
        Ride ride = Ride.fromMap(decodedResponse['ride_details']);
        _rideOrdersBloc.add(OrderRemoved(ride: ride));
      }
      if (decodedResponse['update_type'] == 'ride_orders') {
        Ride ride = Ride.fromMap(decodedResponse['ride_details']);
        _rideOrdersBloc.add(OrdersAdded(ride));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _positionStream.cancel();
    _rideOrdersBloc.add(OrdersReset());
    super.dispose();
  }

  _driverDetails() async {
    return await _driverRepository.getDriverDetailsFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (__, state) async {
              if (state is LoggedIn || state is DetailsUpdate) {
                Driver driver = await _driverDetails();
                if (driver != null) {
                  if (state is DetailsUpdate && driver.blocked) {
                    BlocProvider.of<RiderDetailsBloc>(context)
                        .add(RiderDetailsEvent.BLOCKED_RIDER);
                  } else if (driver.isDelivering) {
                    BlocProvider.of<RiderDetailsBloc>(context)
                        .add(RiderDetailsEvent.RIDER_IS_DELIVERING);
                  }
                }
              }
            },
          ),
          BlocListener<RiderDetailsBloc, RiderDetailsState>(
            listener: (__, state) async {
              if (state is IsBlocked) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/HomePage', (route) => false,
                    arguments: AlertBarArguments(false, true));
                return;
              }

              if (state is IsRiding) {
                if (await isInternetConnected()) {
                  try {
                    var rawRideDetails = await RideRepository().getActiveRide();
                    if (rawRideDetails != null) {
                      Ride ride = Ride.fromMap(rawRideDetails);
                      _chooseOrderInteractiveSheet(ride);
                    }
                  } catch (err) {
                    cprint(err.message, errorIn: 'DriverBlocListener');
                  }
                }
              }
            },
          ),
        ],
        child: WillPopScope(
          onWillPop: () {
            return new Future(() => false);
          },
          child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.grey[100],
              drawer: RiderNavDrawer(),
              body: RefreshIndicator(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child:
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (_, state) {
                        if (state is NonLoggedIn) {
                          WidgetsBinding.instance.addPostFrameCallback((_) =>
                              Navigator.pushReplacementNamed(context, '/'));
                        }
                        if (state.props.isEmpty) {
                          return Container();
                        }
                        return CustomerAppBar();
                      }),
                    ),
                    Expanded(
                        child: BlocBuilder<RideOrdersBloc, RideOrdersState>(
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
                      if (state.isInitial ||
                          !state.isSuccess && state.isLoading) {
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
                          itemCount: state.hasReachedMax
                              ? state.rides.length
                              : state.rides.length + 1,
                          padding: EdgeInsets.only(top: 0, bottom: 20),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (index >= state.rides.length) {
                              return PreLoader();
                            }
                            Ride ride = state.rides[index];
                            return InkWell(
                              onTap: () => _chooseOrderInteractiveSheet(ride),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20),
                                      child: ListTile(
                                        title: Text(
                                          ride.pickupLocation.address,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "Ubuntu",
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              height: 1.4),
                                        ),
                                        subtitle: Text(
                                          getFullTime(ride.createdAt),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Ubuntu",
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              height: 1.6),
                                        ),
                                        contentPadding: EdgeInsets.all(0),
                                        dense: true,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }))
                  ],
                ),
                onRefresh: () async {
                  _rideOrdersBloc.add(OrdersReset());
                  _rideOrdersBloc.add(OrdersFetched(isUser: 0));
                },
              )),
        ));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _rideOrdersBloc.add(OrdersFetched(isUser: 0));
    }
  }

  void _chooseOrderInteractiveSheet(Ride ride) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext bc) {
          return SafeArea(
            child: RiderOrderInteractiveLayout(ride,
                onProcess: () => _onProcessRide(ride)),
          );
        });
  }

  void _onProcessRide(Ride ride) {
    _rideOrdersBloc.add(OrderRemoved(ride: ride));
  }
}
