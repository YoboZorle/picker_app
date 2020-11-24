import 'package:equatable/equatable.dart';
import 'package:pickrr_app/src/models/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class UnDetermined extends AuthenticationState {}

class LoggedIn extends AuthenticationState {
  final User user;

  const LoggedIn(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn { user: $user }';
}

class NonLoggedIn extends AuthenticationState {}