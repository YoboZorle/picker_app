import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/blocs/business/driver_wallet_history/bloc.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';

class DriverWalletHistoryBloc
    extends Bloc<DriverWalletHistoryEvent, DriverWalletHistoryState> {
  final BusinessRepository _businessRepository = BusinessRepository();

  DriverWalletHistoryBloc() : super(DriverWalletHistoryState.empty());

  @override
  Stream<DriverWalletHistoryState> mapEventToState(
      DriverWalletHistoryEvent event) async* {
    final currentState = state;

    if (event is DriverWalletHistoryReset) {
      yield DriverWalletHistoryState.empty();
    }

    if (event is DriverWalletHistoryFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapDriverWalletHistoryFetchedToState(
            currentState, event.riderId);
      }
    }
  }

  Stream<DriverWalletHistoryState> _mapDriverWalletHistoryFetchedToState(
      currentState, riderId) async* {
    yield DriverWalletHistoryState.loading(currentState);

    try {
      final nextPage =
          currentState.isInitial ? 1 : currentState.currentPage + 1;
      if (currentState.isSuccess && nextPage > currentState.lastPage) {
        yield currentState.copyWith(hasReachedMax: true);
        return;
      }
      final result =
          await _fetchDriverWalletHistoryAndGetPages(nextPage, riderId);
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
      yield DriverWalletHistoryState.success(
        histories: histories,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield DriverWalletHistoryState.failure();
    }
  }

  bool _hasReachedMax(DriverWalletHistoryState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchDriverWalletHistoryAndGetPages(
      nextPage, int riderId) async {
    try {
      final response = await _businessRepository.getRiderTransactions(riderId,
          page: nextPage);
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
