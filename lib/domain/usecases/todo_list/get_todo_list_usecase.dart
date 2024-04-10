import 'package:task_manger_app/data/task_manager_repository.dart';

import '../../../constants/logger.dart';
import '../../entities/TodoList.dart';

class GetTodoListUsecase{
  final TaskManagerRepository repository;
  GetTodoListUsecase(this.repository);
  Future<List<TodoList>> fetchTodoList() async {
    try {
      LogManager.info('usecase::fetchTodoList');
      var todoList = await repository.getTodo();
      LogManager.info("get todo List from Api: ${todoList.length}");
      return todoList;
    } on Exception catch (e) {
      LogManager.error('usecase::fetchTodoList::exception =', e);
      throw Exception(e.toString().substring(11));
    }
  }
}