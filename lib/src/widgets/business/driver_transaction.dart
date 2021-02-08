import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/business/driver_wallet_history/bloc.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';

class DriverTransaction extends StatefulWidget {
  final int riderId;

  DriverTransaction({this.riderId});

  @override
  _DriverTransactionState createState() => _DriverTransactionState();
}

class _DriverTransactionState extends State<DriverTransaction> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  DriverWalletHistoryBloc _driverWalletHistoryBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _driverWalletHistoryBloc =
        BlocProvider.of<DriverWalletHistoryBloc>(context);
    _driverWalletHistoryBloc.add(DriverWalletHistoryFetched(widget.riderId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _driverWalletHistoryBloc.add(DriverWalletHistoryReset());
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 10),
                      BlocBuilder<DriverWalletHistoryBloc,
                              DriverWalletHistoryState>(
                          // ignore: missing_return
                          builder: (_, state) {
                        if (state.isFailure) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text("No transaction!"),
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
                          if (state.histories.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text("No transactions!"),
                                  alignment: Alignment.center,
                                ),
                              ],
                            );
                          }
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

  historyDetails(History history) => Card(
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
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(getFullTime(history.createdAt),
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.normal)),
                        history.type == 'DEDUCTION'
                            ? Text("- \u20A6 ${history.amount}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red[500],
                                ))
                            : Text("+ \u20A6 ${history.amount}",
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
    _driverWalletHistoryBloc.add(DriverWalletHistoryReset());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _driverWalletHistoryBloc.add(DriverWalletHistoryFetched(widget.riderId));
    }
  }
}
