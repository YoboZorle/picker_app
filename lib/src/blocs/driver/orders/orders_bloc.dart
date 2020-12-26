import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/driver/orders/bloc.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';

class RiderOrdersHistoryBloc extends Bloc<RiderOrdersEvent, RiderOrdersState> {
  final RideRepository _rideRepository = RideRepository();

  RiderOrdersHistoryBloc() : super(RiderOrdersState.empty());

  @override
  Stream<RiderOrdersState> mapEventToState(RiderOrdersEvent event) async* {
    final currentState = state;

    if (event is OrdersReset) {
      yield RiderOrdersState.empty();
    }

    if (event is RiderOrdersFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapOrdersFetchedToState(currentState);
      }
    }
  }

  Stream<RiderOrdersState> _mapOrdersFetchedToState(currentState) async* {
    yield RiderOrdersState.loading(currentState);

    try {
      final nextPage =
          currentState.isInitial ? 1 : currentState.currentPage + 1;
      if (currentState.isSuccess && nextPage > currentState.lastPage) {
        yield currentState.copyWith(hasReachedMax: true);
        return;
      }
      final result = await _fetchOrdersAndGetPages(nextPage);
      bool hasReachedMax = false;
      var rides = result['orders'];

      if (currentState.isInitial) {
        hasReachedMax = result['currentPage'] + 1 > result['lastPage'];
      }
      if (!currentState.isInitial) {
        if (nextPage >= result['lastPage']) {
          hasReachedMax = true;
        }
        rides = currentState.rides + rides;
      }
      yield RiderOrdersState.success(
        rides: rides,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield RiderOrdersState.failure();
    }
  }

  bool _hasReachedMax(RiderOrdersState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchOrdersAndGetPages(nextPage) async {
    try {
      final response = await _rideRepository.getRiderOrders(page: nextPage);
      if (response == null) {
        return {'orders': [], 'currentPage': 1, 'lastPage': 1};
      }
      final List<Ride> orders = _orders(response['results']);

      final int currentPage = response['pagination']['current_page'];
      final int lastPage = response['pagination']['last_page'];
      return {
        'orders': orders,
        'currentPage': currentPage,
        'lastPage': lastPage
      };
    } catch (e) {
      throw Exception('error fetching ride orders');
    }
  }

  List<Ride> _orders(rawRides) {
    List<Ride> rides = [];
    rawRides.forEach((rawDetail) {
      Ride ride = Ride.fromMap(rawDetail);
      rides.add(ride);
    });

    return rides;
  }
}
