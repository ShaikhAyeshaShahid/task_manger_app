import 'package:task_manger_app/constants/logger.dart';

import '../../../data/task_manager_repository.dart';
import '../../entities/UserLogin.dart';

class UserLoginUsecase {
  final TaskManagerRepository respository;

  UserLoginUsecase(this.respository);

  Future<UserLogin> userLogin(String username, String password) async {
    try {
      LogManager.info('usecase::userLogin::userLogin = $userLogin',);
      return await respository.signIn(username, password);
    } on Exception catch (e) {
      LogManager.error('signin_usecase::signin::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }
}
