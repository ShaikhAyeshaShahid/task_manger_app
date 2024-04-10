part of 'user_login_cubit.dart';

@immutable
abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {
  @override
  List<Object> get props => [];
}

class UserLoginLoading extends UserLoginState {}

class UserLoginSuccess extends UserLoginState {
  final UserLogin user;

  UserLoginSuccess(this.user);
}

class UserLoginFailed extends UserLoginState {
  final String errorMessage;

  UserLoginFailed(this.errorMessage);
}
