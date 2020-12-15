import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';

import 'bloc.dart';

class DriverHistoryBloc extends Bloc<DriverHistoryEvent, DriverHistoryState> {
  final DriverRepository _driverRepository = DriverRepository();

  DriverHistoryBloc() : super(DriverHistoryState.empty());

  @override
  Stream<DriverHistoryState> mapEventToState(DriverHistoryEvent event) async* {
    final currentState = state;

    if (event is DriverHistoryReset) {
      yield DriverHistoryState.empty();
    }

    if (event is DriverHistoryFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapDriverHistoryFetchedToState(currentState);
      }
    }
  }

  Stream<DriverHistoryState> _mapDriverHistoryFetchedToState(
      currentState) async* {
    yield DriverHistoryState.loading(currentState);

    try {
      final nextPage =
      currentState.isInitial ? 1 : currentState.currentPage + 1;
      if (currentState.isSuccess && nextPage > currentState.lastPage) {
        yield currentState.copyWith(hasReachedMax: true);
        return;
      }
      final result = await _fetchDriverHistoryAndGetPages(nextPage);
      bool hasReachedMax = false;
      var histories = result['histories'];

      if (currentState.isInitial) {
        hasReachedMax = result['currentPage'] + 1 > result['lastPage'];
      }
      if (!currentState.isInitial) {
        if (nextPage >= result['lastPage']) {
          hasReachedMax = true;
        }
        histories = currentState.histories + histories;
      }
      yield DriverHistoryState.success(
        histories: histories,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield DriverHistoryState.failure();
    }
  }

  bool _hasReachedMax(DriverHistoryState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchDriverHistoryAndGetPages(nextPage) async {
    try {
      final response = await _driverRepository.getDriverWalletHistory(page: nextPage);
      if (response == null) {
        return {'histories': [], 'currentPage': 1, 'lastPage': 1};
      }
      final List<History> histories = _walletHistories(response['results']);

      final int currentPage = response['pagination']['current_page'];
      final int lastPage = response['pagination']['last_page'];
      return {
        'histories': histories,
        'currentPage': currentPage,
        'lastPage': lastPage
      };
    } catch (e) {
      throw Exception('error fetching wallet histories');
    }
  }

  List<History> _walletHistories(rawHistory) {
    List<History> histories = [];
    rawHistory.forEach((rawDetail) {
      History history = History.fromMap(rawDetail);
      histories.add(history);
    });

    return histories;
  }
}