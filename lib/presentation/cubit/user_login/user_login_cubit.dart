import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manger_app/domain/entities/UserLogin.dart';

import '../../../constants/logger.dart';
import '../../../domain/usecases/user_login/userlogin_usecase.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  final UserLoginUsecase userLoginUsecase;
  UserLoginCubit(this.userLoginUsecase) : super(UserLoginInitial());

  void userLogin(String username, String password) async {
    try{
      emit(UserLoginLoading());
      UserLogin userLogin = await userLoginUsecase.userLogin(username, password);
      LogManager.info('cubit::userLogin::userLogin = $userLogin',);
      emit(UserLoginSuccess(userLogin));
    } on Exception catch (e) {
      emit(UserLoginFailed(e.toString().substring(11)));
      LogManager.error('signup_cubit::signup::exception =', e);
    }
  }
}
