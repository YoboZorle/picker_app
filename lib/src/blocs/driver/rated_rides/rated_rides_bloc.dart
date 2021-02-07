import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/driver/rated_rides/bloc.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';

class RatedRidesBloc extends Bloc<RatedRidesEvent, RatedRidesState> {
  final BusinessRepository _businessRepository = BusinessRepository();

  RatedRidesBloc() : super(RatedRidesState.empty());

  @override
  Stream<RatedRidesState> mapEventToState(RatedRidesEvent event) async* {
    final currentState = state;

    if (event is RatedRidesReset) {
      yield RatedRidesState.empty();
    }

    if (event is RatedRidesFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapOrdersFetchedToState(currentState, event.riderId);
      }
    }
  }

  Stream<RatedRidesState> _mapOrdersFetchedToState(
      currentState, riderId) async* {
    yield RatedRidesState.loading(currentState);

    try {
      final nextPage =
          currentState.isInitial ? 1 : currentState.currentPage + 1;
      if (currentState.isSuccess && nextPage > currentState.lastPage) {
        yield currentState.copyWith(hasReachedMax: true);
        return;
      }
      final result = await _fetchRatedRidesAndGetPages(nextPage, riderId);
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
      yield RatedRidesState.success(
        rides: rides,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield RatedRidesState.failure();
    }
  }

  bool _hasReachedMax(RatedRidesState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchRatedRidesAndGetPages(
      nextPage, riderId) async {
    try {
      final response = await _businessRepository.getRatedRidesBusiness(riderId,
          page: nextPage);
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
