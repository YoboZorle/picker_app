import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/ride/orders/bloc.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';

class RideOrdersBloc extends Bloc<OrdersEvent, RideOrdersState> {
  final RideRepository _rideRepository = RideRepository();

  RideOrdersBloc() : super(RideOrdersState.empty());

  @override
  Stream<RideOrdersState> mapEventToState(OrdersEvent event) async* {
    final currentState = state;

    if (event is OrdersReset) {
      yield RideOrdersState.empty();
    }

    if (event is OrdersFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapOrdersFetchedToState(currentState);
      }
    }

    if(event is OrdersAdded){
      yield* _mapOrdersAddedToState(event.ride, currentState);
    }
  }

  Stream<RideOrdersState> _mapOrdersAddedToState(Ride ride, currentState) async* {
    List<Ride> rides = currentState.rides.insert(0, ride);
    yield currentState.copyWith(rides: rides);
  }

  Stream<RideOrdersState> _mapOrdersFetchedToState(
      currentState) async* {
    yield RideOrdersState.loading(currentState);

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
      yield RideOrdersState.success(
        rides: rides,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield RideOrdersState.failure();
    }
  }

  bool _hasReachedMax(RideOrdersState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchOrdersAndGetPages(nextPage) async {
    try {
      final response = await _rideRepository.getOrders(page: nextPage);
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