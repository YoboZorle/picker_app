import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/blocs/driver/driver_history/bloc.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'package:pickrr_app/src/utils/transitionAppbar/transition_appbar.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';

class DriverWallet extends StatefulWidget {
  DriverWallet({Key key}) : super(key: key);

  @override
  _DriverWalletState createState() => _DriverWalletState();
}

class _DriverWalletState extends State<DriverWallet> {
  final DriverRepository _driverRepository = DriverRepository();
  final _scrollController = ScrollController();
  final currencyFormatter =
  NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  final _scrollThreshold = 200.0;
  DriverHistoryBloc _historyBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _historyBloc = BlocProvider.of<DriverHistoryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _historyBloc.add(DriverHistoryReset());
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                TransitionAppBar(
                  extent: 100,
                  avatar: Text("Total balance",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Ubuntu',
                        fontSize: 15,
                      )),
                  title: Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Row(children: <Widget>[
                      FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.none ||
                              snapshot.hasData == null ||
                              !snapshot.hasData) {
                            return SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            );
                          }
                          final driverDetails = snapshot.data;
                          return Text("\u20A6 ${driverDetails['balance']}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Ubuntu',
                                fontSize: 27,
                              ));
                        },
                        future: _driverRepository.getDriverWalletDetails(),
                      ),
                      Expanded(child: SizedBox()),
                    ]),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 10),
                      BlocBuilder<DriverHistoryBloc, DriverHistoryState>(
                          // ignore: missing_return
                          builder: (_, state) {
                        if (state.isFailure) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text("No history!"),
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
                          return ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.all(8.0),
                              reverse: true,
                              shrinkWrap: true,
                              itemCount: state.hasReachedMax
                                  ? state.histories.length
                                  : state.histories.length + 1,
                              physics: const BouncingScrollPhysics(),
                              dragStartBehavior: DragStartBehavior.down,
                              itemBuilder: (_, index) {
                                if (index >= state.histories.length) {
                                  return PreLoader();
                                }
                                History history = state.histories[index];
                                return historyDetails(history);
                              });
                        }
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  historyDetails(History history) =>
      Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Text("\u20A6 ${history.balance}",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(getFullTime(history.createdAt),
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal)),
                        history.type == 'DEDUCTION' ? Text("- \u20A6 ${history.amount}",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.red[500],
                            )) : Text("+ \u20A6 ${history.amount}",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.green[500],
                            ))
                      ],
                    )
                  ],
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _historyBloc.add(DriverHistoryReset());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _historyBloc.add(DriverHistoryFetched());
    }
  }
}
