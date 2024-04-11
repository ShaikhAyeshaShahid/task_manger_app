import '../../../constants/logger.dart';
import '../../../data/task_manager_repository.dart';
import '../../entities/UpdateTodo.dart';

class UpdateTaskUsecase {
  final TaskManagerRepository respository;

  UpdateTaskUsecase(this.respository);

  Future<UpdateTodo> updateTask(bool completed) async {
    try {
      LogManager.info(
        'usecase::updateTaskUsecase:: = $updateTask(completed)',
      );
      return await respository.updateTask(completed);
    } on Exception catch (e) {
      LogManager.error('updateTaskUsecase::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }
}
