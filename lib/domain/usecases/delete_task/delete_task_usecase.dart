import 'package:task_manger_app/domain/entities/DeleteTodo.dart';

import '../../../constants/logger.dart';
import '../../../data/task_manager_repository.dart';

class DeleteTaskUsecase {
  final TaskManagerRepository respository;

  DeleteTaskUsecase(this.respository);

  Future<DeleteTodo> deleteTask() async {
    try {
      LogManager.info(
        'usecase::DeleteTaskUsecase:: = $deleteTask',
      );
      return await respository.deleteTask();
    } on Exception catch (e) {
      LogManager.error('deleteTask::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }
}