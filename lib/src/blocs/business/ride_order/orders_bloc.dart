import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/business/ride_order/bloc.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';

class BusinessRideOrdersBloc
    extends Bloc<BusinessOrdersEvent, BusinessRideOrdersState> {
  final RideRepository _rideRepository = RideRepository();

  BusinessRideOrdersBloc() : super(BusinessRideOrdersState.empty());

  @override
  Stream<BusinessRideOrdersState> mapEventToState(
      BusinessOrdersEvent event) async* {
    final currentState = state;

    if (event is BusinessOrdersReset) {
      yield BusinessRideOrdersState.empty();
    }

    if (event is BusinessOrdersFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapOrdersFetchedToState(currentState);
      }
    }

    if (event is BusinessOrdersAdded) {
      yield* _mapOrdersAddedToState(event.ride, currentState);
    }

    if (event is BusinessOrdersRemoved) {
      yield* _mapOrdersRemovedToState(event.ride, currentState);
    }
  }

  Stream<BusinessRideOrdersState> _mapOrdersAddedToState(
      Ride ride, currentState) async* {
    List<Ride> rides = currentState.rides.insert(0, ride);
    yield currentState.copyWith(rides: rides);
  }

  Stream<BusinessRideOrdersState> _mapOrdersRemovedToState(
      Ride ride, currentState) async* {
    final int rideIndex =
        currentState.rides.indexWhere((element) => element.id == ride.id);
    if (rideIndex > -1) {
      currentState.rides.removeAt(rideIndex);
      yield currentState.copyWith(rides: currentState.rides);
    }
  }

  Stream<BusinessRideOrdersState> _mapOrdersFetchedToState(
      currentState) async* {
    yield BusinessRideOrdersState.loading(currentState);

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
      yield BusinessRideOrdersState.success(
        rides: rides,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield BusinessRideOrdersState.failure();
    }
  }

  bool _hasReachedMax(BusinessRideOrdersState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchOrdersAndGetPages(nextPage) async {
    try {
      final response =
          await _rideRepository.getOrdersForBusiness(page: nextPage);
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
