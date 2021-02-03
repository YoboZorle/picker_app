import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';

import 'bloc.dart';

class BusinessTransactionBloc
    extends Bloc<BusinessTransactionEvent, BusinessTransactionState> {
  final BusinessRepository _businessRepository = BusinessRepository();

  BusinessTransactionBloc() : super(BusinessTransactionState.empty());

  @override
  Stream<BusinessTransactionState> mapEventToState(
      BusinessTransactionEvent event) async* {
    final currentState = state;

    if (event is BusinessTransactionReset) {
      yield BusinessTransactionState.empty();
    }

    if (event is BusinessTransactionFetched) {
      if (!_hasReachedMax(currentState)) {
        yield* _mapBusinessTransactionFetchedToState(currentState);
      }
    }
  }

  Stream<BusinessTransactionState> _mapBusinessTransactionFetchedToState(
      currentState) async* {
    yield BusinessTransactionState.loading(currentState);

    try {
      final nextPage =
          currentState.isInitial ? 1 : currentState.currentPage + 1;
      if (currentState.isSuccess && nextPage > currentState.lastPage) {
        yield currentState.copyWith(hasReachedMax: true);
        return;
      }
      final result = await _fetchBusinessTransactionAndGetPages(nextPage);
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
      yield BusinessTransactionState.success(
        histories: histories,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: hasReachedMax,
      );
    } catch (e) {
      yield BusinessTransactionState.failure();
    }
  }

  bool _hasReachedMax(BusinessTransactionState state) =>
      state.isSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchBusinessTransactionAndGetPages(
      nextPage) async {
    try {
      final response =
          await _businessRepository.getBusinessTransactions(page: nextPage);
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
