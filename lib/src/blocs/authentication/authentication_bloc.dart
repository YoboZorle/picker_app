import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/helpers/db/user.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/repositories/user.dart';

import 'bloc.dart';

enum AuthenticationEvent { AUTHENTICATED, LOGGED_OUT, APP_STARTED }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository _userRepository = UserRepository();

  AuthenticationBloc() : super(UnDetermined());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event == AuthenticationEvent.APP_STARTED) {
      yield* _mapAppStartedToState();
    } else if (event == AuthenticationEvent.AUTHENTICATED) {
      yield* _mapLoggedInToState();
    } else if (event == AuthenticationEvent.LOGGED_OUT) {
      var currentState = state;
      yield* _mapLoggedOutToState(currentState);
    }
  }

  Stream<AuthenticationState> _loadPersistedUserDetails(User user) async* {
    final upToDateUserDetailsMap =
        await _userRepository.getUserDetails(user.id);
    final upToDateUserDetails = User.fromMap(upToDateUserDetailsMap);
    persistUserDetails(upToDateUserDetails);
    yield LoggedIn(upToDateUserDetails);
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final User user = await _userRepository.getUser();
        yield LoggedIn(user);
        if (await isInternetConnected()) {
          yield* _loadPersistedUserDetails(user);
        }
      } else {
        yield NonLoggedIn();
      }
    } catch (err) {
      cprint(err, errorIn: '_mapAppStartedToState');
      yield NonLoggedIn();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      final User user = await _userRepository.getUser();
      yield LoggedIn(user);
      if (await isInternetConnected()) {
        yield* _loadPersistedUserDetails(user);
      }
    } catch (_) {
      yield NonLoggedIn();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(
      AuthenticationState currentState) async* {
    yield NonLoggedIn();
    _userRepository.signOutFromDevice();
    if (currentState is LoggedIn) {
      final User user = currentState.props.first;
      UserProvider helper = UserProvider.instance;
      helper.delete(user.id);
    }
  }
}
