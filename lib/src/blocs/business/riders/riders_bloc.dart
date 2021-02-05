import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/business/riders/bloc.dart';
import 'package:pickrr_app/src/helpers/db/driver.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';

class BusinessRidersBloc
    extends Bloc<BusinessRidersEvent, BusinessRidersState> {
  final BusinessRepository _businessRepository = BusinessRepository();

  BusinessRidersBloc() : super(BusinessRidersState.empty());

  @override
  Stream<BusinessRidersState> mapEventToState(
      BusinessRidersEvent event) async* {
    final currentState = state;

    if (event is RidersFetchReset) {
      yield BusinessRidersState.empty();
    }

    if (event is RidersFetched) {
      if (!_hasReachedMax(currentState) ||
          _hasReachedMax(currentState) && event.isSearching) {
        yield* _mapFetchRoomToState(currentState,
            query: event.query, isSearching: event.isSearching);
      }
    }
  }

  Stream<BusinessRidersState> _mapFetchRoomToState(
    currentState, {
    String query,
    bool isSearching,
  }) async* {
    if ((!currentState.hasReachedMax || isSearching)) {
      yield BusinessRidersState.loading(currentState);

      try {
        final nextPage = currentState.isInitial || isSearching
            ? 1
            : currentState.currentPage + 1;
        if (currentState.isSuccess && nextPage > currentState.lastPage) {
          yield currentState.copyWith(hasReachedMax: true);
          return;
        }
        final result = await _fetchRidersAndGetPages(nextPage, query: query);
        bool hasReachedMax = false;
        var drivers = result['drivers'];

        if (currentState.isInitial) {
          hasReachedMax = result['currentPage'] + 1 > result['lastPage'];
        }
        if (!currentState.isInitial) {
          if (nextPage > currentState.lastPage) {
            hasReachedMax = true;
          }
          drivers = isSearching ? drivers : currentState.drivers + drivers;
        }
        yield BusinessRidersState.success(
          drivers: drivers,
          currentPage: result['currentPage'],
          lastPage: result['lastPage'],
          hasReachedMax: hasReachedMax,
        );
      } catch (e) {
        yield BusinessRidersState.failure();
      }
    }
  }

  bool _hasReachedMax(BusinessRidersState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchRidersAndGetPages(nextPage,
      {String query}) async {
    try {
      final response =
          await _businessRepository.getAllRiders(page: nextPage, query: query);
      if (response == null) {
        return {'drivers': [], 'currentPage': 1, 'lastPage': 1};
      }
      final List<Driver> drivers = _drivers(response['results']);

      final int currentPage = response['pagination']['current_page'];
      final int lastPage = response['pagination']['last_page'];
      return {
        'drivers': drivers,
        'currentPage': currentPage,
        'lastPage': lastPage
      };
    } catch (e) {
      throw Exception('error fetching riders');
    }
  }

  List<Driver> _drivers(result) {
    List<Driver> drivers = [];
    result.forEach((rawDetails) {
      Driver driver = Driver.fromMap(Driver().formatToMap(rawDetails));
      drivers.add(driver);
      DriverProvider helper = DriverProvider.instance;
      helper.updateOrInsert(driver).then((val) {});
      if(driver.details != null) {
        persistUserDetails(driver.details);
      }
    });

    return drivers;
  }
}
