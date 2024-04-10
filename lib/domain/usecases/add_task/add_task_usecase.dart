import 'package:task_manger_app/domain/entities/AddTask.dart';
import '../../../constants/logger.dart';
import '../../../data/task_manager_repository.dart';
import '../../entities/AddTask.dart';

class AddTaskUsecase {
  final TaskManagerRepository respository;

  AddTaskUsecase(this.respository);

  Future<AddTask> addTask(String todo, bool completed, int? userId) async {
    try {
      LogManager.info('usecase::addTaskUsecase::addTaskUsecase = $addTask',);
      return await respository.addTask(todo, completed, userId);
    } on Exception catch (e) {
      LogManager.error('addTaskUsecase::addTaskUsecase::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }
}
